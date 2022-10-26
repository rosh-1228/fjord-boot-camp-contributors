# frozen_string_literal: true

class Commit < ApplicationRecord
  belongs_to :contributor
end
