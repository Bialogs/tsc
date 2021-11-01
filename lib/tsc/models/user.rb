# frozen_string_literal: true

module Tsc
  module Models
    # User model
    class User < ApplicationRecord
      has_many :scores
      has_many :channels, through: :scores

      validates_uniqueness_of :name
    end
  end
end
