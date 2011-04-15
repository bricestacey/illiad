# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "illiad/version"

Gem::Specification.new do |s|
  s.name        = "illiad"
  s.version     = Illiad::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brice Stacey"]
  s.email       = ["bricestacey@gmail.com"]
  s.homepage    = "https://github.com/bricestacey/illiad"
  s.summary     = %q{ActiveRecord, webcirc, and other utilities for Illiad Interlibrary Loan}
  s.description = %q{ActiveRecord, webcirc, and other utilities for Illiad Interlibrary Loan}

  s.rubyforge_project = "illiad"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency('rspec')

  s.add_dependency('activerecord')
  s.add_dependency('activerecord-sqlserver-adapter')
  s.add_dependency('tiny_tds')
end
