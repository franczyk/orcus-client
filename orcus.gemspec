# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{orcus}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gary Franczyk"]
  s.date = %q{2010-10-31}
  s.description = %q{Orcus Automation Application}
  s.email = %q{gary@franczyk.com}
  s.extra_rdoc_files = ["README", "lib/orcus.rb"]
  s.files = ["README", "Rakefile", "lib/orcus.rb", "Manifest", "orcus.gemspec"]
  s.homepage = %q{http://gary.franczyk.com/}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Orcus", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{orcus}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Orcus Automation Application}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
