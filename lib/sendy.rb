require 'sendy/base'
require "sendy/client"
require 'sendy/version'

module Sendy

  class << self

    def new(sendy_url, api_key = nil)
      Sendy::Client.new(sendy_url, api_key)
    end

  end

end