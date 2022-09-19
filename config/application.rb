require_relative "boot"

require "rails/all"
require "graphql/client"
require "graphql/client/http"

Bundler.require(*Rails.groups)

module FjordBootCampContributors
  class Application < Rails::Application
    config.load_defaults 6.1

    HTTP = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
      def headers(context)
        { "Authorization": ENV["GITHUB_ACCESS_TOKEN"] }
      end
    end
  
    Schema = GraphQL::Client.load_schema(HTTP)
    Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
  end
end
