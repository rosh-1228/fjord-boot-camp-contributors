class CommitsController < ApplicationController
  def index
    @contributor = set_contributor
    @index = set_comments(@contributor)
    @contributors = all_contributors
  end

  private

  def set_contributor
    Contributor.find_by(name: params[:contributor_name])
  end

  def set_comments(contributor)
    Commit.where(contributor_id: contributor.id)
  end
end
