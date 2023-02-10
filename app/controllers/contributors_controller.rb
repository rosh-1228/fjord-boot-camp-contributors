# frozen_string_literal: true

class ContributorsController < ApplicationController
  def index
    @commit_ranks = Contributor.rank(@commit_ranks, params[:period])
  end
end
