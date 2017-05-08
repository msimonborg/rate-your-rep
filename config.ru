# frozen_string_literal: true

require './config/environment'

if ActiveRecord::Migrator.needs_migration? && !test?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride

use CallsController
use RepsController
use UsersController
use Rack::Protection

run ApplicationController
