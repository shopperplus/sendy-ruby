module Sendy
  class Base

    def initialize(options)
      @sendy_url = options.delete(:sendy_url) || raise(ArgumentError, "sendy_url required")
      @api_key = options.delete(:api_key) || raise(ArgumentError, "api_key required")
      @list_ids = options.delete(:list_ids) || raise(ArgumentError, "list_ids required")

      @client = Client.new @sendy_url, @api_key
      int_log
    end

    def send_raw_email(mail, args = {})
      from_name = mail.from[0].split("@")[0]
      res = @client.create_campaign(from_name: from_name, from_email: mail.from[0], reply_to: mail.from[0], title: mail.subject, subject: mail.subject, html_text: mail.body.raw_source, list_ids: @list_ids, send_campaign: 1)
      @logger.info(res)
    end

    def int_log
      @logger ||= begin
        require 'logger'
        ::Logger.new(STDOUT)
      end
      @logger.level = Logger::WARN
      @logger
    end

    alias :deliver! :send_raw_email
    alias :deliver  :send_raw_email

  end
end