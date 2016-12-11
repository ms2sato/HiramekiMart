# -*- encoding: utf-8 -*-
# stub: autonumeric-rails 1.9.46.2 ruby lib

Gem::Specification.new do |s|
  s.name = "autonumeric-rails"
  s.version = "1.9.46.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["randoum"]
  s.date = "2016-10-19"
  s.description = "autoNumeric.js library automatically formats currency and numbers. With an ujs flavor it is now directly usable in a rails project. All credits for autoNumeric.js library its-self go to its creator BobKnothe"
  s.email = ["randoum@gmail.com"]
  s.homepage = "https://github.com/randoum/autonumeric-rails"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "autoNumeric.js library with an ujs flavor, ready-to-use for rails."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jquery-rails>, [">= 2.0.2"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rails>, ["~> 4.2.0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
      s.add_development_dependency(%q<rspec-html-matchers>, [">= 0"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0"])
      s.add_development_dependency(%q<capybara>, [">= 0"])
      s.add_development_dependency(%q<selenium-webdriver>, ["= 2.53.4"])
      s.add_development_dependency(%q<headless>, [">= 0"])
    else
      s.add_dependency(%q<jquery-rails>, [">= 2.0.2"])
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rails>, ["~> 4.2.0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
      s.add_dependency(%q<rspec-html-matchers>, [">= 0"])
      s.add_dependency(%q<database_cleaner>, [">= 0"])
      s.add_dependency(%q<capybara>, [">= 0"])
      s.add_dependency(%q<selenium-webdriver>, ["= 2.53.4"])
      s.add_dependency(%q<headless>, [">= 0"])
    end
  else
    s.add_dependency(%q<jquery-rails>, [">= 2.0.2"])
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rails>, ["~> 4.2.0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
    s.add_dependency(%q<rspec-html-matchers>, [">= 0"])
    s.add_dependency(%q<database_cleaner>, [">= 0"])
    s.add_dependency(%q<capybara>, [">= 0"])
    s.add_dependency(%q<selenium-webdriver>, ["= 2.53.4"])
    s.add_dependency(%q<headless>, [">= 0"])
  end
end
