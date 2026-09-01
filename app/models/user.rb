class User < ApplicationRecord
  has_secure_password

  has_one_attached :avatar
  has_one_attached :background

  generates_token_for :email_verification, expires_in: 2.days do
    email
  end

  generates_token_for :password_reset, expires_in: 20.minutes do
    password_salt.last(10)
  end

  has_many :sessions, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, allow_nil: true, length: { minimum: 8 }
  validates :name, presence: true
  validate :avatar_must_be_attached, on: :update
  validates_acceptance_of :terms_of_service

  normalizes :email, with: -> { _1.strip.downcase }

  before_validation :set_defaults, on: :create

  before_validation if: :email_changed?, on: :update do
    self.verified = false
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end

  def avatar_url
    if avatar.attached?
      Rails.application.routes.url_helpers.rails_blob_url(avatar, only_path: true)
    else
      "https://api.dicebear.com/10.x/critters/png?seed=#{ERB::Util.url_encode(email)}"
    end
  end

  def background_url
    if background.attached?
      Rails.application.routes.url_helpers.rails_blob_url(background, only_path: true)
    else
      "https://images.unsplash.com/photo-1776695799247-b15851a1aa2d"
    end
  end

  private

  def avatar_must_be_attached
    errors.add(:avatar, "must be attached") unless avatar.attached?
  end

  def set_defaults
    self.name = email.split("@").first if name.blank? && email.present?

    if email.present? && !avatar.attached?
      uri = URI("https://api.dicebear.com/10.x/critters/png?seed=#{ERB::Util.url_encode(email)}")
      avatar_data = Net::HTTP.get(uri)
      avatar.attach(
        io: StringIO.new(avatar_data),
        filename: "avatar.png",
        content_type: "image/png"
      )
    end

    unless background.attached?
      uri = URI("https://images.unsplash.com/photo-1776695799247-b15851a1aa2d")
      bg_data = Net::HTTP.get(uri)
      background.attach(
        io: StringIO.new(bg_data),
        filename: "background.jpg",
        content_type: "image/jpeg"
      )
    end
  end
end
