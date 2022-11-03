# frozen_string_literal: true

class Contributors::SearchController < ApplicationController
  def index
    contributor = Contributor.find_by(name: params[:name])

    assign_contributor(contributor) unless contributor.nil?
  end

  private

  def assign_contributor(contributor)
    @contributor = [
      avatar_url: change_nil_avatar_to_default_img(contributor.avatar_url),
      name: contributor.name,
      path: contributor_commits_path(contributor_name: contributor.name),
      commits: contributor.all_time_commits
    ]
  end

  def change_nil_avatar_to_default_img(avatar)
    avatar = '/assets/kkrn_icon_user_9.svg' if avatar.nil?
    avatar
  end
end
