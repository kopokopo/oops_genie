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
      @endpoint = load_config['endpoint']
    end

    def fetch_json(alert_config)
      uri = URI(@endpoint)
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
      response = fetch_json(alert_config)
      response == false ? 'Alert could not be generated.' : 'Alert generated.'
    end

    private

    def load_config
      config_file = Rails.root.join('config', 'opsgenie.yml')

      unless File.exist?(config_file)
        raise MissingConfigFileError, "Configuration file not found: #{config_file}. Please ensure it exists in config/opsgenie.yml and contains the required settings."
      end

      config = YAML.load_file(config_file)
      env_config = config[Rails.env]

      if env_config.empty?
        raise MissingEnvironmentConfigError, "Missing configuration for environment: #{Rails.env}. Please ensure the environment is defined in config/opsgenie.yml."
      end

      unless env_config['endpoint']
        raise MissingConfigKeyError, "Missing 'endpoint' key in opsgenie.yml configuration for environment: #{Rails.env}."
      end

      env_config
    end

    class MissingConfigFileError < StandardError; end

    class MissingEnvironmentConfigError < StandardError; end

    class MissingConfigKeyError < StandardError; end
  end
end
