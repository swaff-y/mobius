require "test_helper"

class PainScoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pain_score = pain_scores(:one)
  end

  test "should get index" do
    get pain_scores_url
    assert_response :success
  end

  test "should get new" do
    get new_pain_score_url
    assert_response :success
  end

  test "should create pain_score" do
    assert_difference('PainScore.count') do
      post pain_scores_url, params: { pain_score: { day: @pain_score.day, patient: @pain_score.patient, procedure: @pain_score.procedure, score: @pain_score.score } }
    end

    assert_redirected_to pain_score_url(PainScore.last)
  end

  test "should show pain_score" do
    get pain_score_url(@pain_score)
    assert_response :success
  end

  test "should get edit" do
    get edit_pain_score_url(@pain_score)
    assert_response :success
  end

  test "should update pain_score" do
    patch pain_score_url(@pain_score), params: { pain_score: { day: @pain_score.day, patient: @pain_score.patient, procedure: @pain_score.procedure, score: @pain_score.score } }
    assert_redirected_to pain_score_url(@pain_score)
  end

  test "should destroy pain_score" do
    assert_difference('PainScore.count', -1) do
      delete pain_score_url(@pain_score)
    end

    assert_redirected_to pain_scores_url
  end
end
