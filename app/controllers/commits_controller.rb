# frozen_string_literal: true

class CommitsController < ApplicationController
  def index
    @contributor = set_contributor
    binding.pry
    @index = search_comments(@contributor)
  end

  private

  def set_contributor
    contributor = Contributor.find_by(name: params[:contributor_name])
    contributor.avatar_url = '/assets/blank.svg' if contributor.avatar_url.nil?
    contributor
  end

  def search_comments(contributor)
    Commit.where(contributor_id: contributor.id).order(committed_on: :DESC)
  end
end
