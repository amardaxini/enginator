# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{enginator}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Amar Daxini"]
  s.date = %q{2009-08-05}
  s.default_executable = %q{Enginator.rb}
  s.description = %q{A collection of useful generator scripts for Rails engine.}
  s.email = %q{amar.daxini (at) gmail (dot) com}
  s.executables = ["Enginator.rb"]
  s.extra_rdoc_files = ["lib/enginator.rb", "bin/Enginator.rb", "README", "README.txt"]
  s.files = ["enginator.gemspec", "History.txt", "lib/enginator.rb", "bin/Enginator.rb", "Rakefile", "Manifest", "README", "rails_generators/USAGE", "rails_generators/templates/my_db.yml", "rails_generators/templates/USAGE", "rails_generators/templates/init.rb", "rails_generators/templates/uninstall.rb", "rails_generators/templates/unit_test.rb", "rails_generators/templates/Rakefile", "rails_generators/templates/generator.rb", "rails_generators/templates/README", "rails_generators/templates/test_helper.rb", "rails_generators/templates/plugin.rb", "rails_generators/templates/MIT-LICENSE", "rails_generators/templates/install.rb", "rails_generators/templates/load_config.rb", "rails_generators/templates/just.html.erb", "rails_generators/templates/tasks.rake", "rails_generators/engine_generator.rb", "README.txt", "Readme.rdoc", "test/test_enginator.rb"]
  s.homepage = %q{}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Enginator", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{enginator}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A collection of useful generator scripts for Rails engine.}
  s.test_files = ["test/test_enginator.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
