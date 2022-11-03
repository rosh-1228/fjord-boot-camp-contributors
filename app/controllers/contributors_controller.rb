# frozen_string_literal: true

class ContributorsController < ApplicationController
  def index
    @commit_ranks = []

    collect_contributors(@commit_ranks)
    commit_count = @commit_ranks.map { |hash| hash[:commits] }
    if commit_count
      commit_counts_sort_reverse = commit_count.sort.reverse
      commit_count.map! { |commit_number| commit_counts_sort_reverse.index(commit_number) + 1 }
      @commit_ranks.zip(commit_count) { |contributor, rank| contributor[:rank] = rank }
    end
    @commit_ranks.sort_by! { |hash| hash[:rank] }
  end

  private

  def change_nil_avatar_to_default_img(avatar)
    avatar = '/assets/kkrn_icon_user_9.svg' if avatar.nil?
    avatar
  end

  def collect_contributors(commit_ranks)
    Contributor.where.not(choice_period_commit_count).each do |contributor|
      commit_ranks << {
        avatar_url: change_nil_avatar_to_default_img(contributor.avatar_url),
        rank: contributor.rank,
        path: contributor_commits_path(contributor_name: contributor.name),
        name: contributor.name,
        first_committed_on: contributor.first_committed_on,
        commits: choice_period_commit_count(contributor)
      }
    end
    commit_ranks
  end

  def choice_period_commit_count(contributor = nil)
    case params[:period]
    when 'today'
      contributor ? contributor.today_commits : { today_commits: 0 }
    when 'this-week'
      contributor ? contributor.this_week_commits : { this_week_commits: 0 }
    when 'this-month', nil
      contributor ? contributor.this_month_commits : { this_month_commits: 0 }
    when 'this-year'
      contributor ? contributor.this_year_commits : { this_year_commits: 0 }
    when 'all-time'
      contributor ? contributor.all_time_commits : { all_time_commits: 0 }
    end
  end
end
