# frozen_string_literal: true

module ImportDB
  def import_contributor(contributors)
    contributors = contributors.uniq
    if Contributor.all.count.zero?
      contributors.shift(Contributor.all.count) if Contributor.all.count < contributors.count
      Contributor.import %i[name avatar_url], contributors
    end
  end

  def change_name_to_id(commits)
    names = Contributor.all.pluck(:id, :name).map { |id, name| { id: id, name: name } }

    commits.map do |commit|
      commit[3] = names.find { |hash| hash[:name] == commit[3] }[:id] unless names.find { |hash| hash[:name] == commit[3] }.nil?
    end
  end

  def import_commits(commits)
    change_name_to_id(commits)

    if Commit.all.count.zero?
      Commit.import %i[hash committed_on message contributor_id], commits
    elsif Commit.all.count < commits.count
      commits.shift(Commit.all.count)
      Commit.import %i[hash committed_on message contributor_id], commits
    end
  end
end
