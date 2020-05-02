# OopsGenie
This is a minimal gem than integrated to the OpsGenie API specification
Right now only OpsGenie Alerts are implemented

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
