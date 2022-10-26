# frozen_string_literal: true

class CreateContributors < ActiveRecord::Migration[6.1]
  def change
    create_table :contributors do |t|
      t.string  :name, index: true
      t.string  :avatar_url
      t.date    :first_committed_on
      t.integer :rank
      t.integer :today_commits
      t.integer :this_week_commits
      t.integer :this_month_commits
      t.integer :this_year_commits
      t.integer :all_time_commits

      t.timestamps
    end
  end
end
