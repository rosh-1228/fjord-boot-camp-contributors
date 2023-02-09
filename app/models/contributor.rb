# frozen_string_literal: true

class Contributor < ApplicationRecord
  has_many :commits

  PERIODS =
    {
      'this-month' => 'This month',
      'this-year' => 'This year',
      'this-week' => 'This week',
      'today' => 'Today',
      'all-time' => 'All time'
    }.freeze

    def self.search_contributors(contributer_name)
      where('name like ?', "%#{ActiveRecord::Base.sanitize_sql_like(contributer_name)}%")
    end
end
