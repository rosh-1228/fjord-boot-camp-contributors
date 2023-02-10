# frozen_string_literal: true

class Contributor < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :commits

  PERIODS =
    {
      'this-month' => 'This month',
      'this-year' => 'This year',
      'this-week' => 'This week',
      'today' => 'Today',
      'all-time' => 'All time'
    }.freeze

  class << self
    include Rails.application.routes.url_helpers
  end

  def self.rank(period)
    commit_ranks = []

    collect_contributors(commit_ranks, period)
    commit_count = commit_ranks.map { |hash| hash[:commits] }
    if commit_count
      commit_counts_sort_reverse = commit_count.sort.reverse
      commit_count.map! { |commit_number| commit_counts_sort_reverse.index(commit_number) + 1 }
      commit_ranks.zip(commit_count) { |contributor, rank| contributor[:rank] = rank }
    end
    commit_ranks.sort_by! { |hash| hash[:rank] }
  end

  def self.search_contributors(contributer_name)
    where('name like ?', "%#{ActiveRecord::Base.sanitize_sql_like(contributer_name)}%")
  end

  def self.change_for_display(contributers)
    contributers.map do |contributor|
      assign_contributor(contributor) unless contributor.nil?
    end
  end

  def self.collect_contributors(commit_ranks, period)
    Contributor.where.not(choice_period_commit_count(period)).each do |contributor|
      commit_ranks << {
        avatar_url: change_nil_avatar_to_default_img(contributor.avatar_url),
        rank: contributor.rank,
        path: contributor_commits_path(contributor_name: contributor.name),
        name: contributor.name,
        first_committed_on: contributor.first_committed_on,
        commits: choice_period_commit_count(period, contributor)
      }
    end
    commit_ranks
  end

  def self.choice_period_commit_count(period, contributor = nil)
    case period
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

  def self.assign_contributor(contributor)
    {
      avatar_url: change_nil_avatar_to_default_img(contributor.avatar_url),
      name: contributor.name,
      path: Rails.application.routes.url_helpers.contributor_commits_path(contributor_name: contributor.name),
      commits: contributor.all_time_commits
    }
  end

  def self.change_nil_avatar_to_default_img(avatar)
    avatar = '/assets/blank.svg' if avatar.nil?
    avatar
  end
end
