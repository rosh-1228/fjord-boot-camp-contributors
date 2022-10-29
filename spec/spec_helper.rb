# frozen_string_literal: true

require 'capybara/rspec'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
Capybara.javascript_driver = :selenium_chrome_headless

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:each, type: :system) do |_example|
    driven_by :selenium, screen_size: [1400, 1400], using: :headless_chrome do |options|
      options.add_argument('--disable-dev-sim-usage')
      options.add_argument('--no-sandbox')
    end
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.example_status_persistence_file_path = 'spec/examples.txt'

  config.disable_monkey_patching!

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.profile_examples = 10

  config.order = :random
  Kernel.srand config.seed
end
