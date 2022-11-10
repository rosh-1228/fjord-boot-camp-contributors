# frozen_string_literal: true

class Contributors::SearchController < ApplicationController
  def index
    @contributors = []
    search_contributors = Contributor.where('name like ?', "%#{ActiveRecord::Base.sanitize_sql_like(params[:name])}%")
    search_contributors.each do |contributor|
      @contributors << assign_contributor(contributor) unless contributor.nil?
    end
  end

  private

  def assign_contributor(contributor)
    {
      avatar_url: change_nil_avatar_to_default_img(contributor.avatar_url),
      name: contributor.name,
      path: contributor_commits_path(contributor_name: contributor.name),
      commits: contributor.all_time_commits
    }
  end

  def change_nil_avatar_to_default_img(avatar)
    avatar = '/assets/blank.svg' if avatar.nil?
    avatar
  end
end
