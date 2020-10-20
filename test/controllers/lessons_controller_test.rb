require 'test_helper'

class LessonsControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get lessons_top_url
    assert_response :success
  end

  test "should get about" do
    get lessons_about_url
    assert_response :success
  end

  test "should get index" do
    get lessons_index_url
    assert_response :success
  end

  test "should get show" do
    get lessons_show_url
    assert_response :success
  end

  test "should get create" do
    get lessons_create_url
    assert_response :success
  end

  test "should get complete" do
    get lessons_complete_url
    assert_response :success
  end

end
