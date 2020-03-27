require 'test_helper'

class FreelancersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get freelancers_index_url
    assert_response :success
  end

  test "should get new" do
    get freelancers_new_url
    assert_response :success
  end

  test "should get create" do
    get freelancers_create_url
    assert_response :success
  end

  test "should get edit" do
    get freelancers_edit_url
    assert_response :success
  end

  test "should get update" do
    get freelancers_update_url
    assert_response :success
  end

  test "should get show" do
    get freelancers_show_url
    assert_response :success
  end

  test "should get destroy" do
    get freelancers_destroy_url
    assert_response :success
  end

end
