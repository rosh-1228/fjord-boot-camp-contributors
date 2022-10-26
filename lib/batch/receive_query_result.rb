# frozen_string_literal: true

module ReceiveQuery
  def query_github(definition, variables = {})
    response = FjordBootCampContributors::Client.query(definition, variables: variables, context: client_context)

    raise QueryError, response.errors[:data].join(', ') if response.errors.any?

    response.original_hash
  end

  def client_context
    { access_token: FjordBootCampContributors::Application.secrets.github_access_token }
  end
end
