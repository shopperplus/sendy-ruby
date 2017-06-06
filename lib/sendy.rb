require "sendy/client"

module Sendy
  class << self

    def new(sendy_url, api_key = nil)
      Sendy::Client.new(sendy_url, api_key)
    end

  end
end