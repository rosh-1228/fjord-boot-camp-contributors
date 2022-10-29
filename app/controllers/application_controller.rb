# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :all_contributors

  def test_method
    # This is a method for CI confirmation.
    # It is turned off as soon as the confirmation is finished.
  end
end
