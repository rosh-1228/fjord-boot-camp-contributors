class ApplicationController < ActionController::Base
  helper_method :all_contributors

  class QueryError < StandardError; end

  private
  def query(definition, variables = {})
    response = FjordBootCampContributors::Client.query(definition, variables: variables, context: client_context)

    if response.errors.any?
      raise QueryError.new(response.errors[:data].join(", "))
    else
      response.original_hash
    end
  end

  def client_context
    { access_token: FjordBootCampContributors::Application.secrets.github_access_token }
  end
end
