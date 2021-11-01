# frozen_string_literal: true

require 'httparty'

module Tsc
  module Http
    class PerspectiveClient
      include HTTParty

      def initialize
        @base_uri = 'https://commentanalyzer.googleapis.com/v1alpha1/'
        @key = Configuration.new(false).google_api_key
      end

      def analyze(message)
        params = {
          comment: {
            text: message
          },
          languages: ['en'],
          requestedAttributes: {
            TOXICITY: {}
          }
        }

        response = HTTParty.post("#{@base_uri}comments:analyze?key=#{@key}", {
                                   headers: { "Content-Type": 'application/json' },
                                   body: params.to_json
                                 })
        return unless response.code == 200

        number = JSON.parse(response.body)['attributeScores']['TOXICITY']['summaryScore']['value'] * 100
        number.round(2)
      end
    end
  end
end
