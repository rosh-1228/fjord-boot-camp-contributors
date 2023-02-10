# frozen_string_literal: true

class CommitsController < ApplicationController
  def index
    @contributor = Commit.find_contributor(params[:contributor_name])
    @index = Commit.search_comments(@contributor)
  end
end
