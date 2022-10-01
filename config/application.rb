require_relative "boot"

require "rails/all"
require "graphql/client"
require "graphql/client/http"

Bundler.require(*Rails.groups)

module FjordBootCampContributors
  class Application < Rails::Application
    config.load_defaults 6.1

    config.autoload_paths += Dir["#{config.root}/lib"]
  end

  HTTP = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
    def headers(context)
      #p Rails.application.credentials[:github][:secret_key]
      { "Authorization": Rails.application.credentials[:github][:secret_key] }
    end
  end

  Schema = GraphQL::Client.load_schema(HTTP)
  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
end
