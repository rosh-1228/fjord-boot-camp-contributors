# frozen_string_literal: true

module CommonModule
  extend ActiveSupport::Concern

  def self.replace_default_img(avatar)
    avatar = '/assets/blank.svg' if avatar.nil?
    avatar
  end
end
