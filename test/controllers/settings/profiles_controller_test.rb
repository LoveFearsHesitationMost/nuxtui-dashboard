require "test_helper"

class Settings::ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in_as(users(:lazaro_nixon))
    @user.update_columns(name: "Lazaro Nixon")
    @user.reload
    @user.avatar.attach(
      io: StringIO.new("fake image data"),
      filename: "avatar.png",
      content_type: "image/png"
    )
  end

  # --- show ---

  test "should get show" do
    get settings_profile_path
    assert_response :success
  end

  test "show returns profile props" do
    get settings_profile_path
    assert_response :success
    assert_equal @user.name, inertia.props[:profile][:name]
    assert_equal @user.bio, inertia.props[:profile][:bio]
    assert_equal @user.private_email, inertia.props[:profile][:private_email]
    assert_equal @user.avatar_url, inertia.props[:profile][:avatar_url]
    assert_equal @user.background_url, inertia.props[:profile][:background_url]
  end

  test "should redirect to sign in when unauthenticated" do
    delete session_path(@user.sessions.last)
    get settings_profile_path
    assert_redirected_to sign_in_path
  end

  # --- update ---

  test "should update name" do
    patch settings_profile_path, params: { name: "New Name" }
    assert_redirected_to settings_profile_path
    assert_equal "Profile updated successfully.", flash[:notice]
    assert_equal "New Name", @user.reload.name
  end

  test "should update bio" do
    patch settings_profile_path, params: { bio: "Hello world" }
    assert_redirected_to settings_profile_path
    assert_equal "Hello world", @user.reload.bio
  end

  test "should update private_email" do
    patch settings_profile_path, params: { private_email: true }
    assert_redirected_to settings_profile_path
    assert_equal true, @user.reload.private_email
  end

  test "should update multiple fields at once" do
    patch settings_profile_path, params: { name: "Multi", bio: "Updated bio", private_email: true }
    assert_redirected_to settings_profile_path
    @user.reload
    assert_equal "Multi", @user.name
    assert_equal "Updated bio", @user.bio
    assert_equal true, @user.private_email
  end

  test "should reject blank name and return errors" do
    patch settings_profile_path, params: { name: "" }
    assert_redirected_to settings_profile_path
    assert_nil flash[:notice]
  end

  test "should redirect to sign in when updating unauthenticated" do
    delete session_path(@user.sessions.last)
    patch settings_profile_path, params: { name: "Hacker" }
    assert_redirected_to sign_in_path
  end
end
