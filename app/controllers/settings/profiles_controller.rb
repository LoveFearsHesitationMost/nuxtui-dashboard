class Settings::ProfilesController < InertiaController
  def show
    render inertia: {
      profile: profile_props
    }
  end

  def update
    attrs = profile_params
    attrs = attrs.except(:avatar) unless attrs[:avatar].present?
    attrs = attrs.except(:background) unless attrs[:background].present?

    if Current.user.update(attrs)
      redirect_back_or_to settings_profile_path, notice: "Profile updated successfully."
    else
      redirect_back_or_to settings_profile_path, inertia: {
        profile: profile_props,
        errors: Current.user.errors.to_hash(true)
      }
    end
  end

  private

  def profile_props
    {
      name: Current.user.name,
      bio: Current.user.bio,
      private_email: Current.user.private_email,
      avatar_url: Current.user.avatar_url,
      background_url: Current.user.background_url
    }
  end

  def profile_params
    params.permit(:name, :bio, :private_email, :avatar, :background)
  end
end
