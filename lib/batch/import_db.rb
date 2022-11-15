# frozen_string_literal: true

module ImportDB
  def import_contributor(contributors)
    contributors = contributors.uniq
    all_contibutors_count = Contributor.all.count
    repo_contributors_count = contributors.count

    contributors.shift(Contributor.all.count) if all_contibutors_count < repo_contributors_count
    Contributor.import %i[name avatar_url], contributors unless all_contibutors_count >= repo_contributors_count
  end

  def import_commits(commits)
    commits = commits.uniq
    change_name_to_id(commits)
    all_commits_count = Commit.all.count
    repo_commits_count = commits.count

    commits.shift(Commit.all.count) if all_commits_count < repo_commits_count
    Commit.import %i[hash committed_on message contributor_id], commits unless all_commits_count >= repo_commits_count
  end

  def change_name_to_id(commits)
    names = Contributor.all.pluck(:id, :name).map { |id, name| { id: id, name: name } }

    commits.map do |commit|
      commit[3] = names.find { |hash| hash[:name] == commit[3] }[:id] unless names.find { |hash| hash[:name] == commit[3] }.nil?
    end
  end
end
