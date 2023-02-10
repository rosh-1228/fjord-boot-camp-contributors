# frozen_string_literal: true

class Contributors::SearchController < ApplicationController
  def index
    contributers = Contributor.search_contributors(params[:name])
    @contributors = Contributor.change_for_display(contributers)
  end
end
