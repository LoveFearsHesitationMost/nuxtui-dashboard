require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:lazaro_nixon)
    Rails.cache.clear
  end

  test "should get index" do
    sign_in_as @user

    get sessions_url
    assert_response :success
  end

  test "should get new" do
    get sign_in_url
    assert_response :success
  end

  test "should sign in" do
    post sign_in_url, params: { email: @user.email, password: "Secret1*3*5*" }
    assert_redirected_to root_url

    get root_url
    assert_response :success
  end

  test "should not sign in with wrong credentials" do
    post sign_in_url, params: { email: @user.email, password: "SecretWrong1*3" }
    assert_redirected_to sign_in_url
    assert_equal "Your credential is invalid, check and try again", flash[:alert]

    assert_redirected_to sign_in_url
  end

  test "should sign out" do
    sign_in_as @user

    delete session_url(@user.sessions.last)
    assert_redirected_to root_url
  end

  test "should rate limit sign in attempts" do
    # Rate limit is 10 requests within 3 minutes
    # Make 10 requests with wrong credentials (they fail but still count)
    10.times do
      post sign_in_url, params: { email: @user.email, password: "WrongPassword123" }
      assert_redirected_to sign_in_url
    end

    # 11th request should be rate limited
    post sign_in_url, params: { email: @user.email, password: "WrongPassword123" }
    assert_redirected_to sign_in_url
    follow_redirect!
    assert_equal "Too many requests. Please try again later.", flash[:alert]

    # limit pool is empty after 4 minutes
    travel 4.minutes
    post sign_in_url, params: { email: @user.email, password: "WrongPassword123" }
    assert_redirected_to sign_in_url
  end
end
