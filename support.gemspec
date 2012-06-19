# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "support/version"

Gem::Specification.new do |s|
  s.name        = "mambo-support"
  s.version     = Support::VERSION
  s.authors     = ["Paul Schuegraf"]
  s.email       = ["paul@verticallabs.ca"]
  s.homepage    = ""
  s.summary     = %q{Mambo support utilities}
  s.description = %q{Mambo support utilities}

  s.rubyforge_project = "support"

  s.files         = `git ls-files`.split("\n")

  s.add_runtime_dependency "rails"
end
