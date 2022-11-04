# frozen_string_literal: true

module ContributorCommitArray
  def create_array_contributors_commits(fetched_commits, contributors, commits)
    fetched_commits.each do |node|
      avatar_url = nil
      login_name = node['node']['author']['name']
      if node['node']['author']['user']
        avatar_url = node['node']['author']['user']['avatarUrl']
        login_name = node['node']['author']['user']['login']
      end

      contributors << [login_name, avatar_url]
      commits << [node['node']['oid'], node['node']['author']['date'].to_date, node['node']['message'], login_name]
    end
  end
end
