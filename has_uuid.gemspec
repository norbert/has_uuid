# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "has_uuid/version"

Gem::Specification.new do |s|
  s.name        = "has_uuid"
  s.version     = HasUuid::VERSION
  s.authors     = ["Timo Rößner"]
  s.email       = ["timo.roessner@googlemail.com"]
  s.homepage    = ""
  s.summary     = %q{The has_uuid gem adds a UUID to your AR models.}
  s.description = %q{The has_uuid gem adds a UUID to your AR models. See the README for details.}

  s.rubyforge_project = "has_uuid"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency 'activerecord'
  s.add_dependency 'uuidtools'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'sqlite3'
end
