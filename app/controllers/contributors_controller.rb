# frozen_string_literal: true

class ContributorsController < ApplicationController
  def index
    @commit_ranks = []

    Contributor.collect_contributors(@commit_ranks, params[:period])
    commit_count = @commit_ranks.map { |hash| hash[:commits] }
    if commit_count
      commit_counts_sort_reverse = commit_count.sort.reverse
      commit_count.map! { |commit_number| commit_counts_sort_reverse.index(commit_number) + 1 }
      @commit_ranks.zip(commit_count) { |contributor, rank| contributor[:rank] = rank }
    end
    @commit_ranks.sort_by! { |hash| hash[:rank] }
  end

  private

  def change_nil_avatar_to_default_img(avatar)
    avatar = '/assets/blank.svg' if avatar.nil?
    avatar
  end
end
