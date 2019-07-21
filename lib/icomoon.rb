require "icomoon/version"

module Icomoon
  class Error < StandardError; end
  def self.update(zipfile)
    begin
      zipfile = File.join(zipfile)
      app_root = Dir.getwd
      tmpdir = File.join(app_root, 'tmp', 'iconfont')
      vendorfontsdir = File.join(app_root, 'app', 'assets', 'fonts')
      vendorcssdir = File.join(app_root, 'app', 'assets', 'stylesheets')

      if !File.exist?(File.join(app_root, 'tmp')) || !File.exist?(vendorfontsdir) || !File.exist?(vendorcssdir)
        abort "Current directory not a Rails app directory."
      end

      unless File.directory? tmpdir
        system "mkdir #{tmpdir}"
      end

      system "unzip -u #{zipfile} -d #{tmpdir}"

      Dir.glob(File.join(tmpdir, 'fonts', '*')) do |file|
        puts "Copying #{file} to #{vendorfontsdir}"
        system "cp #{file} #{vendorfontsdir}"
      end

      puts 'Copying the stylesheet'
      stylesheet = File.join(vendorcssdir, 'icons.scss')
      system "cp #{File.join(tmpdir, 'style.css')} #{stylesheet}"
      
      puts 'Updating font URLs in stylesheet'
      stylesheet_content = File.read(stylesheet)
      stylesheet_content.gsub!("url('fonts/", "font-url('")
      File.open(stylesheet, 'w') do |file|
        file.write(stylesheet_content)
      end

      puts 'Updating selection.json file'
      system "cp -rf #{File.join(tmpdir, 'selection.json')} #{File.join(app_root, 'public', 'selection.json')}"

    ensure
      if File.directory? tmpdir
        puts 'Deleting tmp folder'
        system "rm -rf #{tmpdir}"
      end
    end
  end
end
