# frozen_string_literal: true

class Commit < ApplicationRecord
  belongs_to :contributor

  def self.find_contributor(contributor_name)
    contributor = Contributor.find_by(name: contributor_name)
    contributor.avatar_url = '/assets/blank.svg' if contributor.avatar_url.nil?
    contributor
  end

  def self.search_comments(contributor)
    Commit.where(contributor_id: contributor.id).order(committed_on: :DESC)
  end
end
