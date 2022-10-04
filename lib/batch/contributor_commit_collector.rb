class Batch::ContributorCommitCollector
  class QueryError < StandardError; end

  Query = FjordBootCampContributors::Client.parse <<-GRAPHQL
  query($after: String){
    repository(owner: "fjordllc", name: "bootcamp") {
      ref(qualifiedName: "main") {
        target {
          ... on Commit {
            history(first: 100, after: $after) {
              pageInfo {
                hasNextPage
                endCursor
              }
              totalCount
              edges {
                node {
                  oid
                  message
                  author {
                    date
                    name
                    user {
                      login
                      avatarUrl
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
GRAPHQL

  def self.regist_db
    p "#{Time.now} start contributor and commit from github"

    graphql_cursol = nil
    contributors_for_registration = []
    commits_for_registration = []
    
    fetched_commits = query_github(Query, after: graphql_cursol)

    create_array_contributors_commits(fetched_commits['data']['repository']['ref']['target']['history']['edges'], contributors_for_registration, commits_for_registration)
    
    ((fetched_commits['data']['repository']['ref']['target']['history']['totalCount'] / 100) + 1).times do
      graphql_cursol = fetched_commits['data']['repository']['ref']['target']['history']['pageInfo']['endCursor']
      
      create_array_contributors_commits(fetched_commits['data']['repository']['ref']['target']['history']['edges'], contributors_for_registration, commits_for_registration)
      fetched_commits = query_github(Query, after: graphql_cursol)
    end
    
    import_contributor(contributors_for_registration)
    import_commits(commits_for_registration)

    update_commit_count_rank
    p "#{Time.now} end contributor and commit from github"
  end

  def self.rotate_graphql_query(graphql_cursol, contributors_for_registration, commits_for_registration)
    fetched_commits = query_github(Query, after: graphql_cursol)
    commits_history = fetched_commits['data']['repository']['ref']['target']['history']

    create_array_contributors_commits(commits_history['edges'], contributors_for_registration, commits_for_registration)
    
    ((commits_history['totalCount'] / 100) + 1).times do
      graphql_cursol = commits_history['pageInfo']['endCursor']
      
      create_array_contributors_commits(commits_history['edges'], contributors_for_registration, commits_for_registration)
      fetched_commits = query_github(Query, after: graphql_cursol)
    end
  end

  def self.import_commits(commits)
    names = Contributor.all.pluck(:id, :name).map {|id, name| {id: id, name: name }}
    commits.map {|commit| commit[3] = names.find{|hash| hash[:name] == commit[3]}[:id]}
    Commit.import [:hash, :committed_on, :message, :contributor_id], commits
  end

  def self.import_contributor(contributors)
    contributors = contributors.uniq
    if Contributor.all.count == 0
      Contributor.import [:name, :avatar_url], contributors
    elsif Contributor.all.count < contributors.count
      contributors.shift(Contributor.all.count)
      Contributor.import [:name, :avatar_url], contributors
    end
  end


  def self.query_github(definition, variables = {})
    response = FjordBootCampContributors::Client.query(definition, variables: variables, context: client_context)

    if response.errors.any?
      raise QueryError.new(response.errors[:data].join(", "))
    else
      response.original_hash
    end
  end

  def self.client_context
    { access_token: FjordBootCampContributors::Application.secrets.github_access_token }
  end

  def self.create_array_contributors_commits(fetched_commits, contributors, commits)
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

  def self.update_commit_count_rank
    commit_counts = []
    (1..Contributor.all.length).each do |contributor_id|
      commit_counts << Commit.where(contributor_id: contributor_id).count
    end
    commit_counts_sort_reverse = commit_counts.sort.reverse
    commit_counts.map! {|n| commit_counts_sort_reverse.index(n) + 1 }
    commit_counts.each.with_index(1) do |contributor_rank, contributor_id|
      update_contributor(contributor_rank, contributor_id)
    end
  end

  def self.update_contributor(contributor_rank, contributor_id)
    Contributor.where(id: contributor_id).update(
      rank: contributor_rank,
      first_committed_on: find_first_committed_on(contributor_id),
      today_commits: find_contributor_commits_count(contributor_id, Date.current.beginning_of_day..Date.current.end_of_day),
      this_week_commits: find_contributor_commits_count(contributor_id, Date.current.beginning_of_week..Date.current.end_of_week),
      this_month_commits: find_contributor_commits_count(contributor_id, Date.current.beginning_of_month..Date.current.end_of_month),
      this_year_commits: find_contributor_commits_count(contributor_id, Date.current.beginning_of_year..Date.current.end_of_year),
      all_time_commits: Contributor.find_by(id: contributor_id).commits.count
    )
  end

  def self.find_first_committed_on(contributor_id)
    Commit.where(contributor_id: contributor_id).order(:committed_on).first.committed_on unless Commit.where(contributor_id: contributor_id).empty?
  end

  def self.find_contributor_commits_count(contributor_id, commit_period)
    Contributor.find_by(id: contributor_id).commits.where(committed_on: commit_period).count
  end

  def self.collect_contributors(commit_ranks)
    Contributor.where.not(choice_period_commit_count).each do |contributor|
      commit_ranks << {
        avatar_url: contributor.avatar_url,
        rank: contributor.rank,
        path: contributor_commits_path(contributor_name: contributor.name),
        name: contributor.name,
        commits: choice_period_commit_count(contributor)
      }
    end
    commit_ranks
  end

  def self.choice_period_commit_count(contributor = nil)
    period = case params[:period]
    when 'today'
      contributor ? contributor.today_commits : {today_commits: 0}
    when 'this-week'
      contributor ? contributor.this_week_commits : {this_week_commits: 0}
    when 'this-month', nil
      contributor ? contributor.this_month_commits : {this_month_commits: 0}
    when 'this-year'
      contributor ? contributor.this_year_commits : {this_year_commits: 0}
    when 'all-time'
      contributor ? contributor.all_time_commits : {all_time_commits: 0}
    end
  end
end
