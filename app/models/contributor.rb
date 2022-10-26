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
end
