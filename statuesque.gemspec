# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "statuesque/version"

Gem::Specification.new do |s|
  s.name        = "statuesque"
  s.version     = Statuesque::VERSION
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = ">= 1.9.2"
  s.authors     = ["Noah Gibbs"]
  s.email       = ["noah_gibbs@yahoo.com"]
  s.homepage    = "http://blog.angelbob.com"
  s.summary     = %q{Statuesque summarizes objects in a humanlike way, by similarities and differences}
  s.description = %q{Statuesque summarizes objects in a humanlike way, by similarities and differences}

  s.rubyforge_project = "statuesque"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  [["activesupport", ">= 3.0"]].each { |dep| s.add_dependency(*dep) }

  [["scope"],
   ["rake"]
  ].each { |dep| s.add_development_dependency(*dep) }
end
