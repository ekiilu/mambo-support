# -*- encoding: utf-8 -*-

#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

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
  
  s.add_development_dependency "mmcopyrights"
end
