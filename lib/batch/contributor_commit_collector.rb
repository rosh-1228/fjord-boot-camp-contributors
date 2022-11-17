# frozen_string_literal: true

require_relative './github_query'
require_relative './create_array'
require_relative './import_db'
require_relative './update_rank'
require_relative './receive_query_result'

class ContributorCommitCollector
  include GithubQuery
  include ContributorCommitArray
  include ImportDB
  include UpdateRank
  include ReceiveQuery
end

collector = ContributorCommitCollector.new

Query = collector.create_query

def regist_db(collector)
  p "#{Time.now} start contributor and commit from github"
  p ActiveRecord::Base.connection_config

  graphql_cursol = nil
  contributors = []
  commits = []

  fetched_commits = collector.query_github(Query, after: graphql_cursol)

  collector.create_array_contributors_commits(fetched_commits['data']['repository']['ref']['target']['history']['edges'], contributors, commits)

  ((fetched_commits['data']['repository']['ref']['target']['history']['totalCount'] / 100) + 1).times do
    graphql_cursol = fetched_commits['data']['repository']['ref']['target']['history']['pageInfo']['endCursor']

    collector.create_array_contributors_commits(fetched_commits['data']['repository']['ref']['target']['history']['edges'], contributors, commits)
    fetched_commits = collector.query_github(Query, after: graphql_cursol)
  end

  collector.import_contributor(contributors)
  collector.import_commits(commits)

  collector.update_commit_count_rank
  p "#{Time.now} end contributor and commit from github"
end

regist_db(collector)
