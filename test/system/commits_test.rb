require "application_system_test_case"

class CommitsTest < ApplicationSystemTestCase
  setup do
    @commit = commits(:one)
  end

  test "visiting the index" do
    visit commits_url
    assert_selector "h1", text: "Commits"
  end

  test "creating a Commit" do
    visit commits_url
    click_on "New Commit"

    fill_in "Committed on", with: @commit.committed_on
    fill_in "Contributor", with: @commit.contributor
    fill_in "Hash", with: @commit.hash
    fill_in "Message", with: @commit.message
    click_on "Create Commit"

    assert_text "Commit was successfully created"
    click_on "Back"
  end

  test "updating a Commit" do
    visit commits_url
    click_on "Edit", match: :first

    fill_in "Committed on", with: @commit.committed_on
    fill_in "Contributor", with: @commit.contributor
    fill_in "Hash", with: @commit.hash
    fill_in "Message", with: @commit.message
    click_on "Update Commit"

    assert_text "Commit was successfully updated"
    click_on "Back"
  end

  test "destroying a Commit" do
    visit commits_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Commit was successfully destroyed"
  end
end
