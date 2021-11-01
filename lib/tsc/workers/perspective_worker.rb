# frozen_string_literal: true

require 'sidekiq'
require 'active_record'

require_relative '../configuration'
require_relative '../conf/mods'
require_relative '../conf/sidekiq'
require_relative '../errors'
require_relative '../models/application_record'
require_relative '../models/user'
require_relative '../models/channel'
require_relative '../models/score'

require_relative '../http/perspective_client'

class PerspectiveWorker
  include Sidekiq::Worker
  include Tsc::Models
  include Tsc::Http
  include Tsc::Conf

  def perform(user, channel, body)
    return if !MODS[channel].nil? && MODS[channel].include?(user)

    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: Tsc::Configuration.database)
    user = User.where(name: user).first_or_create
    channel = Channel.where(name: channel).first_or_create
    score = PerspectiveClient.new.analyze(body)
    return if score.nil?

    s = Score.where(user_id: user.id, channel_id: channel.id).first_or_create
    s.messages_sent = s.messages_sent + 1
    s.total_score = s.total_score + score
    s.current_average = (s.total_score / s.messages_sent).round(2)
    s.save!
    ActiveRecord::Base.remove_connection
  end
end
