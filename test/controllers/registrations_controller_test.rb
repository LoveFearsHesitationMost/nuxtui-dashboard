require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    Rails.cache.clear
  end

  test "should get new" do
    get sign_up_url
    assert_response :success
  end

  test "should sign up" do
    assert_difference("User.count") do
      post sign_up_url, params: { email: "lazaronixon@hey.com", password: "Secret1*3*5*", password_confirmation: "Secret1*3*5*" }
    end

    assert_inertia_component "registrations/check_email_guide"
  end

  test "should deny short password" do
    post sign_up_url, params: { email: "lazaronixon@another.com", password: "short", password_confirmation: "short" }
    assert_redirected_to sign_up_url

    follow_redirect!
    assert_equal "Password is too short (minimum is 8 characters)", inertia.props[:errors][:password].first
  end

  test "should deny unmatched password confirmation" do
    post sign_up_url, params: { email: "lazaronixon@third.com", password: "ohmypassword", password_confirmation: "unmatchedpwd:)" }
    assert_redirected_to sign_up_url

    follow_redirect!
    assert_equal "Password confirmation doesn't match Password", inertia.props[:errors][:password_confirmation].first
  end

  # --- Scenario 1: Real email owner tries to register (unverified account exists) ---

  test "should resend verification when unverified account exists with same email" do
    # Create an unverified account (simulating malicious registration)
    User.create!(
      email: "victim@example.com",
      password_digest: BCrypt::Password.create("SomePassword123"),
      verified: false
    )

    assert_no_difference("User.count") do
      assert_emails 1 do
        post sign_up_url, params: {
          email: "victim@example.com",
          password: "NewPassword12345",
          password_confirmation: "NewPassword12345"
        }
      end
    end

    assert_redirected_to sign_up_url
    follow_redirect!

    assert_inertia_component "registrations/new"
    assert_inertia_props errors: {
      email: [ "An account with this email exists but hasn't been verified. We've sent a new verification email with magic link to victim@example.com. Check your inbox." ]
    }
  end

  test "should not create new user when unverified account exists with same email" do
    User.create!(
      email: "victim@example.com",
      password_digest: BCrypt::Password.create("SomePassword123"),
      verified: false
    )

    assert_no_difference("User.count") do
      post sign_up_url, params: {
        email: "victim@example.com",
        password: "NewPassword12345",
        password_confirmation: "NewPassword12345"
      }
    end
  end

  test "should show standard error when verified account exists with same email" do
    # The fixture user lazaro_nixon is verified
    assert_no_difference("User.count") do
      post sign_up_url, params: {
        email: "lazaronixon@hotmail.com",
        password: "SomePassword12345",
        password_confirmation: "SomePassword12345"
      }
    end

    assert_redirected_to sign_up_url
    follow_redirect!

    assert_inertia_component "registrations/new"
    # Should show the standard uniqueness error, not the unverified message
    error_messages = inertia.props[:errors][:email]
    assert error_messages.any? { |msg| msg.include?("has already been taken") },
           "Expected uniqueness error but got: #{error_messages.inspect}"
  end

  # --- Scenario 2: User didn't receive original verification email (resend verification) ---

  test "should resend verification for unverified account via public endpoint" do
    user = User.create!(
      email: "unverified@example.com",
      password_digest: BCrypt::Password.create("SomePassword123"),
      verified: false
    )

    assert_emails 1 do
      post identity_email_verification_url, params: { email: "unverified@example.com" }
    end

    assert_redirected_to sign_in_url
    follow_redirect!

    assert_inertia_flash notice: "If an unverified account exists with that email, we've sent a verification link."
  end

  test "should not leak email existence for unverified resend" do
    # Even if email doesn't exist, should show same message
    assert_emails 0 do
      post identity_email_verification_url, params: { email: "nonexistent@example.com" }
    end

    assert_redirected_to sign_in_url
    follow_redirect!

    # Same message regardless of whether email exists
    assert_inertia_flash notice: "If an unverified account exists with that email, we've sent a verification link."
  end

  test "should not resend verification for verified account" do
    # lazaro_nixon is verified
    assert_emails 0 do
      post identity_email_verification_url, params: { email: "lazaronixon@hotmail.com" }
    end

    assert_redirected_to sign_in_url
    follow_redirect!

    assert_inertia_flash notice: "If an unverified account exists with that email, we've sent a verification link."
  end

  test "should get resend verification form" do
    get new_identity_email_verification_url
    assert_response :success
    assert_inertia_component "identity/email_verifications/new"
  end

  # --- Rate limiting tests ---

  test "should rate limit sign up attempts" do
    # Rate limit is 5 requests within 5 minutes
    # First 5 requests should succeed (even if validation fails)
    5.times do |i|
      post sign_up_url, params: {
        email: "rate#{i}@example.com",
        password: "SomePassword12345",
        password_confirmation: "SomePassword12345"
      }
      # Should either redirect (validation error) or render check_email_guide (success)
      assert_includes [ 302, 200 ], response.status, "Request #{i + 1} should succeed"
    end

    # 6th request should be rate limited
    post sign_up_url, params: {
      email: "rate_limit@example.com",
      password: "SomePassword12345",
      password_confirmation: "SomePassword12345"
    }
    assert_redirected_to sign_up_url
    follow_redirect!
    assert_equal "Too many requests. Please try again later.", flash[:alert]
  end
end
