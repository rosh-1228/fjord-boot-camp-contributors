# frozen_string_literal: true

require_relative '../lib/batch/update_rank'

class UpdatedRank
  include UpdateRank
end

contributors = []
commits = []
rank = UpdatedRank.new

30.times do |name_number|
  contributors << ["contributor#{name_number}", '/assets/blank.svg']
end
Contributor.import %i[name avatar_url], contributors

130.times do |commit_number|
  commits << ["aaaaaaaaaaaaaaaaa#{commit_number}", '2022-11-01', "message #{commit_number}", rand(1..30)]
end
Commit.import %i[hash committed_on message contributor_id], commits

rank.update_commit_count_rank
