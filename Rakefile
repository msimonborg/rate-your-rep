# frozen_string_literal: true
ENV['SINATRA_ENV'] ||= 'development'

require_relative './config/environment'
require 'sinatra/activerecord/rake'

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task default: :spec
rescue LoadError
  # no rspec available
end

desc 'Open a pry console'
task :console do
  Pry.start
end

desc 'Update reps and office_locations'
task :update do
  Rep.all.each { |rep| rep.update active: false }
  OfficeLocation.all.each { |office| office.update active: false }
  Rep.fetch_full_index
end
