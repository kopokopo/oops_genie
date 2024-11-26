# OopsGenie
This is a minimal gem that integrates to the OpsGenie API specification.
Right now only OpsGenie Alerts are implemented. More functionality will follow
later.

## Usage
Create an OopsGenieAlert Object minimally providing your OpsGenie api key and a 
message.
```ruby
alert = OopsGenie::OopsGenieAlert.new('your api key here', 'Testing Alerts')
alert.send_alert
```

Additionally you can set other configuration parameters to the alert object
before sending. eg.
```ruby
alert = OopsGenie::OopsGenieAlert.new('your api key here', 'Testing Alerts')
alert.tags = ['Critical', 'Another tag']
alert.priority = 'P1'
alert.send_alert

```

In the host application, ensure there is configuration file in `config/opsgenie.yml` in the format below:

```yaml
development:
  endpoint: opsgenie-url
  api_key: opsgenie-api-key

production:
  endpoint: opsgenie-url
  api_key: opsgenie-api-key
```

Attributes that can be set on the alert oject are:
  - api_key
  - message
  - alias
  - actions
  - tags
  - details
  - entity
  - priority
  - responders

See the [OpsGenie API](https://docs.opsgenie.com/docs/api-integration) for more information on these.
## Installation
Add this line to your application's Gemfile:

```ruby
gem 'oops_genie'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install oops_genie
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
