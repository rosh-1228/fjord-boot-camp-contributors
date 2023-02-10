# frozen_string_literal: true

class ContributorsController < ApplicationController
  def index
    @commit_ranks = Contributor.rank(params[:period])
  end
end
