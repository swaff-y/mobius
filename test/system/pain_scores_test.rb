require "application_system_test_case"

class PainScoresTest < ApplicationSystemTestCase
  setup do
    @pain_score = pain_scores(:one)
  end

  test "visiting the index" do
    visit pain_scores_url
    assert_selector "h1", text: "Pain Scores"
  end

  test "creating a Pain score" do
    visit pain_scores_url
    click_on "New Pain Score"

    fill_in "Day", with: @pain_score.day
    fill_in "Patient", with: @pain_score.patient
    fill_in "Procedure", with: @pain_score.procedure
    fill_in "Score", with: @pain_score.score
    click_on "Create Pain score"

    assert_text "Pain score was successfully created"
    click_on "Back"
  end

  test "updating a Pain score" do
    visit pain_scores_url
    click_on "Edit", match: :first

    fill_in "Day", with: @pain_score.day
    fill_in "Patient", with: @pain_score.patient
    fill_in "Procedure", with: @pain_score.procedure
    fill_in "Score", with: @pain_score.score
    click_on "Update Pain score"

    assert_text "Pain score was successfully updated"
    click_on "Back"
  end

  test "destroying a Pain score" do
    visit pain_scores_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pain score was successfully destroyed"
  end
end
