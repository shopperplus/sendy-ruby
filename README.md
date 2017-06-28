## Usage

### Basic Use

First create a client instance:

```ruby
client = Sendy.new "http://xxxx.your.sendy.url", "your_api_key"
```

### Subscribe / Unsubscribe

Then you can subscribe or unsubscribe from a list:

```ruby
> client.subscribe list_id, "demo@demo.com", "My Name"
=> true
> client.unsubscribe list_id, "demo@demo.com"
=> false
```

### Subscription Status

To check subscription status for Email address:

```ruby
> client.subscription_status list_id, "demo@demo.com"
=> "Unsubscribed"
```

### Active Subscriber Count

To get active subscriber count of a list:

```ruby
> client.active_subscriber_count list_id
=> 2
```

### Create Campaign

To create new campaign:

```ruby
> client.create_campaign from_name: "demo", from_email: "demo@demo.com", reply_to: "demo@demo.com", title: "Hello, world", subject: "Hello, world", html_text: "<h1>Hello, world</h1>", list_ids: "your_list_ids", send_campaign: 1
=> Campaign created and now sending
```

### For Rails

* create a file name sendy.rb in initializer folder of a Rails application and add below lines to it

```ruby
require "sendy"
ActionMailer::Base.add_delivery_method :sendy, Sendy::Base, {sendy_url: "http://xxxx.your.sendy.url", api_key: "your_api_key", list_ids: "your_list_ids"}
```

There're three required parameters

1. API Endpoint - The URL for Sendy Host.
2. API Key
3. One of your Subscriber lists id, The encrypted & hashed ids can be found under View all lists section named ID.

* configure your environment file to use your custom deliver method

add below line to environments/*.rb

```ruby
config.action_mailer.delivery_method = :sendy
```
