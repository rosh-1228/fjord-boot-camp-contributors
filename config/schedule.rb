# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/environment")

env :path, ENV['PATH']
rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env
set :output, "#{Rails.root}/log/cron.log"

every 6.hours do
  runner 'Batch::ContributorCommitCollector.regist_db'
end
