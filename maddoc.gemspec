# -*- encoding: utf-8 -*-
require File.expand_path('../lib/maddoc/version', __FILE__)


Gem::Specification.new do |gem|
  gem.name          = 'maddoc'
  gem.version       = MadDoc::VERSION
  gem.homepage      = 'http://ixti.github.com/maddoc'
  gem.authors       = %w{Aleksey V Zapparov}
  gem.email         = %w{ixti@member.fsf.org}
  gem.summary       = 'maddoc-#{MadDoc::VERSION}'
  gem.description   = %q{Better markdown to HTML renderer.}

  gem.add_dependency 'redcarpet',   '~> 2.2'
  gem.add_dependency 'slim',        '~> 1.3'
  gem.add_dependency 'sass',        '~> 3.2'
  gem.add_dependency 'sprockets',   '~> 2.8'
  gem.add_dependency 'pygments.rb', '~> 0.3'

  gem.add_development_dependency 'rake'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.require_paths = ['lib']
end
