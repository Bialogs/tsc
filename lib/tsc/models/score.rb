# frozen_string_literal: true

module Tsc
  module Models
    # Score model
    class Score < ApplicationRecord
      belongs_to :user
      belongs_to :channel

      validates :user_id, uniqueness: { scope: :channel_id, message: 'already has a score for the channel' }
    end
  end
end
