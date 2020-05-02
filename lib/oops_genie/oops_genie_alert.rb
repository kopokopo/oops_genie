# frozen_string_literal: true

module OopsGenie
  # configuration object to hold details of an OpsGenie Alert
  class OopsGenieAlert
    attr_accessor :message, :alias, :description, :responders, :actions, :tags,
                  :details, :entity, :priority, :api_key

    def initialize(api_key, message)
      @api_key = api_key
      @message = message
      @alias = nil
      @actions = nil
      @tags = nil
      @details = { description: message }
      @entity = nil
      @priority = nil
      @responders = nil
    end

    def alert_hash
      attrs = {}
      instance_variables.each do |var|
        str = var.to_s.gsub /^@/, ''
        if respond_to? "#{str}="
          attrs[str.to_sym] = instance_variable_get var
        end
      end
      attrs
    end

    def send_alert
      og_client = OopsGenie::OopsGenieClient.new(@api_key)
      response = og_client.send_alert(self)
      puts response
    end
  end
end
