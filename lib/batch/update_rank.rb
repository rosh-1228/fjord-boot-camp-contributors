# frozen_string_literal: true

module UpdateRank
  def update_commit_count_rank
    commit_counts = []
    (1..Contributor.all.length).each do |contributor_id|
      commit_counts << Commit.where(contributor_id: contributor_id).count
    end
    commit_counts_sort_reverse = commit_counts.sort.reverse
    commit_counts.map! { |n| commit_counts_sort_reverse.index(n) + 1 }
    commit_counts.each.with_index(1) do |contributor_rank, contributor_id|
      update_contributor(contributor_rank, contributor_id)
    end
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
    contributor = Commit.where(contributor_id: contributor_id)
    contributor.order(:committed_on).first.committed_on unless contributor.empty?
  end

  def find_contributor_commits_count(contributor_id, commit_period)
    Contributor.find_by(id: contributor_id).commits.where(committed_on: commit_period).count
  end
end
