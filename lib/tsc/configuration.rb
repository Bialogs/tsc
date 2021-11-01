module Tsc
  class Configuration
    attr_reader :oauth_string, :wss_server, :twitch_user, :twitch_channel, :google_api_key

    environment = ENV.fetch('TSC_ENV') { 'development' }
    @database = ENV.fetch('TSC_DATABASE') { "tsc-#{environment}.sqlite3" }
    @database = File.join(Dir.pwd, 'lib', 'tsc', 'db', @database)
    ActiveRecord::Base.logger = Logger.new($stdout)

    def self.raise_unless_present(env)
      ENV.fetch(env) { raise Tsc::ConfigurationError.new(config: env) }
    end

    class << self
      attr_reader :database
    end

    def initialize(configure_twitch = true)
      if configure_twitch
        @oauth_string = Configuration.raise_unless_present('TSC_OAUTH_STRING')
        @twitch_user = Configuration.raise_unless_present('TSC_TWITCH_USER')
        @twitch_channel = Configuration.raise_unless_present('TSC_TWITCH_CHANNEL')
        @wss_server = ENV.fetch('TSC_WSS_SERVER') { 'wss://irc-ws.chat.twitch.tv:443' }
      end
      @google_api_key = Configuration.raise_unless_present('TSC_GOOGLE_API_KEY')
    end
  end
end
