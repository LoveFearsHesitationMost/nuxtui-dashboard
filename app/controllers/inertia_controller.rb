# frozen_string_literal: true

class InertiaController < ApplicationController
  inertia_config default_render: true
  inertia_share auth: {
    user: -> {
      return nil unless Current.user
      Current.user.as_json(only: %i[id name bio email verified created_at updated_at]).merge(
        "avatar_url" => Current.user.avatar_url,
        "background_url" => Current.user.background_url
      )
    },
    session: -> { Current.session&.as_json(only: %i[id]) }
  }
end
