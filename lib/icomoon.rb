require "icomoon/version"

require 'yaml'

module Icomoon
  class Error < StandardError; end
  def self.import(icomoon_files)
    begin
      icomoon_files = File.join(icomoon_files)
      app_root = Dir.getwd
      icon_config = YAML.load_file(File.join(app_root, '.icomoon.yml')).to_hash rescue {}

      working_dir = icon_config["working_directory"] ? File.join(app_root, icon_config["working_directory"], "icofont") : File.join(app_root, 'tmp', 'iconfont')
      working_dir = File.expand_path(working_dir)
      font_dir = icon_config["font_directory"] ? File.join(app_root, icon_config["font_directory"]) : File.join(app_root, 'app', 'assets', 'fonts')
      css_dir = icon_config["stylesheet_directory"] ? File.join(app_root, icon_config["stylesheet_directory"]) : File.join(app_root, 'app', 'assets', 'stylesheets')
      selection_dir = icon_config["selection_directory"] ? File.join(app_root, icon_config["selection_directory"]) : File.join(app_root, 'public', 'selection.json')
      stylesheet_name = icon_config["stylesheet"] || 'icons.css'

      if (!File.exist?(File.join(app_root, 'tmp')) || !icon_config["working_directory"]) || !File.exist?(font_dir) || !File.exist?(css_dir)
        abort "Current directory doesn't seems to be an application directory. please move to project root folder and run again"
      end

      unless File.directory? working_dir
        system "mkdir #{working_dir}"
      end

      if File.extname(icomoon_files) == '.zip'
        system "unzip -u #{icomoon_files} -d #{working_dir}"
        is_temp = true
      else
        working_dir = File.expand_path(icomoon_files)
        is_temp = false
      end

      Dir.glob(File.join(working_dir, 'fonts', '*')) do |file|
        puts "Copying #{file} to #{font_dir}"
        system "cp #{file} #{font_dir}"
      end

      puts 'Copying the stylesheet'
      stylesheet = File.join(css_dir, stylesheet_name)
      File.write(stylesheet, "") unless File.exist?(stylesheet)
      system "cp #{File.join(working_dir, 'style.css')} #{stylesheet}"
      
      puts 'Updating font URLs in stylesheet'
      stylesheet_content = File.read(stylesheet)
      stylesheet_content.gsub!("url('fonts/", "font-url('")
      File.open(stylesheet, 'w') do |file|
        file.write(stylesheet_content)
      end

      puts 'Updating selection.json file'
      system "cp -f #{File.join(working_dir, 'selection.json')} #{File.join(selection_dir)}"

    ensure
      if File.directory?(working_dir) && is_temp
        puts 'Deleting tmp folder'
        system "rm -rf #{working_dir}"
      end
    end
  end
end
