class Contributor < ApplicationRecord
  PERIODS = {
    'all-time'   => 'All time',
    'today'      => 'Today',
    'this-week'  => 'This week',
    'this-month' => 'This month',
    'this-year'  => 'This year',
  }
end
