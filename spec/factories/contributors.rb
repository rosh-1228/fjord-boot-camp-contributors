# frozen_string_literal: true

FactoryBot.define do
  factory :contributor1, class: Contributor do
    id { 1 }
    name { 'rosh-1228' }
    avatar_url { 'https://avatars.githubusercontent.com/u/64620506?u=62fc452d277dff2d1f5d97acbc6a9a6851f3a24a&v=4' }
    first_committed_on { '2021-09-19' }
    rank { 1 }
    today_commits { 0 }
    this_week_commits { 0 }
    this_month_commits { 10 }
    this_year_commits { 20 }
    all_time_commits { 30 }
  end

  factory :contributor2, class: Contributor do
    id { 2 }
    name { 'rosh-0000' }
    avatar_url { 'https://avatars.githubusercontent.com/u/64620506?u=62fc452d277dff2d1f5d97acbc6a9a6851f3a24a&v=4' }
    first_committed_on { '2021-10-19' }
    rank { 2 }
    today_commits { 1 }
    this_week_commits { 3 }
    this_month_commits { 10 }
    this_year_commits { 20 }
    all_time_commits { 25 }
  end

  factory :contributor3, class: Contributor do
    id { 3 }
    name { 'rosh-9999' }
    avatar_url { 'https://avatars.githubusercontent.com/u/64620506?u=62fc452d277dff2d1f5d97acbc6a9a6851f3a24a&v=4' }
    first_committed_on { '2021-11-19' }
    rank { 3 }
    today_commits { 1 }
    this_week_commits { 3 }
    this_month_commits { 5 }
    this_year_commits { 15 }
    all_time_commits { 20 }
  end
end
