class ContributorsController < ApplicationController
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

  def index
    #insert
    #update
    @commit_ranks = []

    collect_contributors(@commit_ranks)
    #@commit_ranks.sort_by! { |hash| hash[:rank] }
    commit_count = @commit_ranks.map {|hash| hash[:commits]}
    if commit_count
      commit_counts_sort_reverse = commit_count.sort.reverse
      commit_count.map! {|n| commit_counts_sort_reverse.index(n) + 1 }
      @commit_ranks.zip(commit_count) {|contributor, rank| contributor[:rank] = rank}
    end
    @commit_ranks.sort_by! { |hash| hash[:rank] }
  end
  
  def search
    contributor_info = Contributor.find_by(name: params[:name])

    @contributor = contributor_info.nil? ? nil : [
      avatar_url: contributor_info.avatar_url,
      name: contributor_info.name,
      path: contributor_commits_path(contributor_name: contributor_info.name),
      commits: contributor_info.all_time_commits
    ]
  end

  def insert
    cursol = nil
    contributors = []
    commits = []
    json = query(Query, after: cursol)

    collect_contributors_commits(json['data']['repository']['ref']['target']['history']['edges'], contributors, commits)
    
    ((json['data']['repository']['ref']['target']['history']['totalCount'] / 100) + 1).times do
      cursol = json['data']['repository']['ref']['target']['history']['pageInfo']['endCursor']
      
      collect_contributors_commits(json['data']['repository']['ref']['target']['history']['edges'], contributors, commits)
      json = query(Query, after: cursol)
    end

    # コントリビューターとコミットを登録するメソッド
    Contributor.import [:name, :avatar_url], contributors.uniq
    names = Contributor.all.pluck(:id, :name).map {|id, name| {id: id, name: name }}
    commits.map {|commit| commit[3] = names.find{|hash| hash[:name] == commit[3]}[:id]}
    Commit.import [:hash, :committed_on, :message, :contributor_id], commits

    update
  end

  def collect_contributors_commits(json, contributors, commits)
    json.each do |node|
      if node['node']['author']['user']
        contributors << [node['node']['author']['user']['login'], node['node']['author']['user']['avatarUrl']]
        commits << [node['node']['oid'], node['node']['author']['date'].to_date, node['node']['message'], node['node']['author']['user']['login']]
      else
        contributors << [node['node']['author']['name'], nil]
        commits << [node['node']['oid'], node['node']['author']['date'].to_date, node['node']['message'], node['node']['author']['name']]
      end
    end
  end

  def update
    commit_counts = []
    (1..Contributor.all.length).each do |contributor_id|
      commit_counts << Commit.where(contributor_id: contributor_id).count
    end
    commit_counts_sort_reverse = commit_counts.sort.reverse
    commit_counts.map! {|n| commit_counts_sort_reverse.index(n) + 1 }

    commit_counts.each.with_index(1) do |contributor_rank, contributor_id|
      # contributorの更新
      update_contributor(contributor_rank, contributor_id)
    end
  end

  private
  def result
    FjordBootCampContributors::Client.query(Query)
  end

  def update_contributor(contributor_rank, contributor_id)
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

  def find_first_committed_on(contributor_id)
    Commit.where(contributor_id: contributor_id).order(:committed_on).first.committed_on unless Commit.where(contributor_id: contributor_id).empty?
  end

  def find_contributor_commits_count(contributor_id, commit_period)
    Contributor.find_by(id: contributor_id).commits.where(committed_on: commit_period).count
  end

  def collect_contributors(commit_ranks)
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

  def choice_period_commit_count(contributor = nil)
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
