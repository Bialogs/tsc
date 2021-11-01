# frozen_string_literal: true

require 'eventmachine'
require 'faye/websocket'
require 'sqlite3'
require 'active_record'
require 'sidekiq'

require_relative 'tsc/version'
require_relative 'tsc/errors'
require_relative 'tsc/configuration'
require_relative 'tsc/irc'

require_relative 'tsc/workers/perspective_worker'

require_relative 'tsc/http/perspective_client'

module Tsc
  conf = Configuration.new

  EM.run do
    ws = Faye::WebSocket::Client.new(conf.wss_server)
    irc = Irc.new(ws, conf.twitch_channel)

    ws.on :open do |_event|
      irc.join(conf.oauth_string, conf.twitch_user)
    end

    ws.on :message do |event|
      p [:message, event.data]
      next if irc.handle_ping(event.data)

      message = irc.parse_message(event.data)
      # If this is the owner of the channel skip this message
      next if message[:user] == message[:channel][1..-1]

      PerspectiveWorker.perform_async(message[:user], message[:channel], message[:body]) unless message.nil?
    end

    ws.on :close do |event|
      p [:close, event.code, event.reason]
      ws = nil
    end
  end
end
