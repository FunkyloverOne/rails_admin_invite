$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'rails_admin_invite/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'rails_admin_invite'
  s.version     = RailsAdminInvite::VERSION
  s.authors     = ['Nazar Matus']
  s.email       = ['funkyloverone@gmail.com']
  s.homepage    = 'https://github.com/FunkyloverOne/rails_admin_invite'
  s.summary     = 'Invite action for RailsAdmin'
  s.description = 'Super easy and flexible way to provide an invitation view and logic in rails_admin'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.0.1'
end
