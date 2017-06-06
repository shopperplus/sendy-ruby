require 'faraday'
module Sendy
  class Client

    def initialize(sendy_url, api_key = nil)
      @url = sendy_url
      @key = api_key || ENV['SENDY_API_KEY']
    end

    def create_campaign(opts={})
      params = {}
      require_params = %i(from_name from_email reply_to title subject html_text)
      optional_params = %i(plain_text query_string)

      require_params.each do |opt|
        params[opt] = opts.delete(opt) || raise(ArgumentError, "opt :#{opt} required")
      end

      if opts[:send_campaign].to_i == 1
        params[:list_ids] = opts.delete(:list_ids) || raise(ArgumentError, "list_ids required if you set send_campaign to 1")
      elsif opts[:send_campaign].to_i == 0
        params[:brand_id] = opts.delete(:brand_id) || raise(ArgumentError, "brand_id required if you set send_campaign to 0")
      else
        raise(ArgumentError, "params send_campaign: Set to 1 if you want to send the campaign as well and not just create a draft. Default is 0")
      end
      params[:send_campaign] = opts[:send_campaign]
      params.merge!(Hash[optional_params.zip(opts.values_at(*optional_params))])
      params[:api_key] = @key

      response = connection.post "api/campaigns/create.php" do |req|
        req.body = params
      end

      response.body
    end

    def subscribe(list_id, email, name = nil)
      response = connection.post "subscribe" do |req|
        params = {list: list_id, email: email, boolean: true}
        params[:name] = name if name
        req.body = params
      end

      !!(response.body =~ /^1$/)
    end

    def unsubscribe(list_id, email)
      response = connection.post "unsubscribe", {list: list_id, email: email, boolean: true}

      !!(response.body =~ /^1$/)
    end

    def subscription_status(list_id, email)
      response = connection.post "api/subscribers/subscription-status.php" do |req|
        req.body = {list_id: list_id, email: email, api_key: @key}
      end

      response.body
    end

    def delete_subscriber(list_id, email)
      response = connection.post "api/subscribers/delete.php" do |req|
        req.body = {list_id: list_id, email: email, api_key: @key}
      end

      !!(response.body =~ /^1$/)
    end

    def active_subscriber_count(list_id)
      response = connection.post "api/subscribers/active-subscriber-count.php" do |req|
        req.body = {list_id: list_id, api_key: @key}
      end

      response.body.to_i
    end

    protected

    def connection
      @connection ||= Faraday.new(:url => @url) do |faraday|
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter
      end
    end

  end
end