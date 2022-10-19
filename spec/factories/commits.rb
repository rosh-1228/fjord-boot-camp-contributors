FactoryBot.define do
  factory :commit, class: Commit do
    association :contributor, factory: :contributor_1
    id { 1 }
    hash { 'abcdefghijklm' }
    committed_on { '2022-01-01'.to_date }
    message { 'system test commit message' }
  end
end
