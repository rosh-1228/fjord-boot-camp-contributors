require 'rails_helper'

RSpec.describe "ContributorTests", type: :system do
  describe 'verify ranking', js: true do
    before do
      create(:contributor_1)
      create(:contributor_2)
      create(:contributor_3)
    end

    it 'verify ranking are in ascending order', js: true do
      visit '/contributors/all-time'
      
      ranking_table = page.find('table').all('tr').map { |row| row.all('th, td').map { |cell| cell.text.strip } }
      ranking_table.shift()
      ranking_table = ranking_table.transpose[0]
      ranking_table.map { |value| value.delete!('#') }
      expect(ranking_table[0].to_i).to eq(1)
      expect(ranking_table[1].to_i).to eq(2)
      expect(ranking_table[2].to_i).to eq(3)
    end
  end

  describe '', js: true do
    it '', js: true do
      create(:contributor_1)
      commits = [["b782403f68b013ac2e5d6ab9f08291b39b4deaca",'2021-01-01',"Merge pull request #5624 from fjordllc/bug/fix-validation-failure\n\nブックマーク登録時にUserが重複した時に発生するバリデーションエラーのバグを修正した",1],["fa47e7eff042bf095e30dd541dc6015f2f1c2f07",'2022-01-01',"Merge pull request #5434 from fjordllc/bug/twitter_card_bug\n\nTwitterに投稿しても画像が出ない",1]]
      Commit.import [:hash, :committed_on, :message, :contributor_id], commits
      commit = Commit.find_by(contributor_id: Contributor.find(1).id)
      visit contributor_commits_path(Contributor.find(commit.contributor_id).name)

      commit_table = page.find('table').all('tr').map { |row| row.all('th, td').map { |cell| cell.text.strip } }
      commit_table.shift()
      commit_table = commit_table.transpose[2]
      
      expect(commit_table[0]).to eq('Merge pull request #5624 from fjordllc/bug/fix-validation-failure ブックマーク登録時にUserが重複した時に発生するバリデーションエラーのバグを修正した')
      expect(commit_table[1]).to eq('Merge pull request #5434 from fjordllc/bug/twitter_card_bug Twitterに投稿しても画像が出ない')
    end
  end
end
