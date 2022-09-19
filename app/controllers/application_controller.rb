class ApplicationController < ActionController::Base
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
    # Use static access token from environment. However, here we have access
    # to the current request so we could configure the token to be retrieved
    # from a session cookie.
    { access_token: FjordBootCampContributors::Application.secrets.github_access_token }
  end
end
