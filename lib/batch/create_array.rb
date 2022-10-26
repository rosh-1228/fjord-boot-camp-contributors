# frozen_string_literal: true

module ContributorCommitArray
  def create_array_contributors_commits(fetched_commits, contributors, commits)
    fetched_commits.each do |node|
      if node['node']['author']['user']
        contributors << [node['node']['author']['user']['login'], node['node']['author']['user']['avatarUrl']]
        commits << [node['node']['oid'], node['node']['author']['date'].to_date, node['node']['message'], node['node']['author']['user']['login']]
      else
        contributors << [node['node']['author']['name'], nil]
        commits << [node['node']['oid'], node['node']['author']['date'].to_date, node['node']['message'], node['node']['author']['name']]
      end
    end
  end
end
