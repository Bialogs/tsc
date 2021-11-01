# frozen_string_literal: true

module Tsc
  module Models
    # Channel model
    class Channel < ApplicationRecord
      has_many :scores
      has_many :users, through: :scores
    end
  end
end
