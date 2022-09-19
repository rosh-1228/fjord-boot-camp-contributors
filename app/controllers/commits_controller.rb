class CommitsController < ApplicationController
  def index
    @contributor = Contributor.find_by(name: params[:contributor_name])
    @index = set_comments(@contributor)
  end

  private

  def set_comments(contributor)
    Commit.where(contributor_id: contributor.id)
  end
end
