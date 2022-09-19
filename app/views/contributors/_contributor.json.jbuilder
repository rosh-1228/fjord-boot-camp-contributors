json.extract! contributor, :id, :name, :avatar_url, :first_committed_on, :rank, :created_at, :updated_at
json.url contributor_url(contributor, format: :json)
