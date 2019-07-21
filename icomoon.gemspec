lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "icomoon/version"

Gem::Specification.new do |spec|
  spec.name          = "icomoon-cli"
  spec.version       = Icomoon::VERSION
  spec.authors       = ["Vishal Taj PM"]
  spec.email         = ["vishaltajpm@gmail.com"]

  spec.summary       = "A command line tool to update icomoon icon sets for rails application"
  spec.description   = "Icomoon gem helps to update icomoon's icons via command line. this gem will automate all the steps to be done while we update icomoon's icon set."
  spec.homepage      = "https://github.com/VishalTaj/icomoon"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/VishalTaj/icomoon"
  spec.metadata["changelog_uri"] = "https://github.com/VishalTaj/icomoon"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.default_executable = "icomoon"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
