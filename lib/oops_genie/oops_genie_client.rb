# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'

module OopsGenie
  # Implement sending an alert to OpsGenie
  #
  class OopsGenieClient
    def initialize(api_key)
      @api_key = api_key
      # TODO: dondeng - Do not hard code this
      @url_prefix = 'https://api.eu.opsgenie.com/v2/alerts'
    end

    def fetch_json(alert_config)
      uri = URI(@url_prefix)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(uri.request_uri,
                                    { 'Content-Type' => 'application/json',
                                      'Authorization' => "GenieKey #{@api_key}" })
      request.body = alert_config.alert_hash.to_json
      res = https.request(request)
      return JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)

      false
    rescue StandardError => e
      puts "Error in oops_genie gem: #{e.message}"
      false
    end

    def send_alert(alert_config)
      response =  fetch_json(alert_config)
      response == false ? 'Alert could not be generated.' : 'Alert generated.'
    end
  end
end
