require "faraday"

module ServiceApi
  # Base is module which should be included in own base Api class.
  #
  #   class MyApi
  #     include ServiceApi::Base
  #
  #     private
  #
  #     def base_url
  #       "http://example.com"
  #     end
  #   end
  #
  module Base
    # If you want to have more methods than get and post override it
    #
    REQUEST_METHODS = %w(get post).freeze

    # Initilizer require config hash as parameter
    #
    #   MyApi.new(api_key: "1234")
    #
    def initialize(options)
      @options = options
      @params = {}
      @connection = build_connection
    end

    private

    attr_reader :connection, :options

    # Build connection, can be override to extend connection settings
    #
    #   def build_connection
    #     connection = super
    #     connection.response :json, content_type: /\bjson$/
    #     connection
    #   end
    #
    def build_connection
      connection = Faraday.new(url: base_url)
      connection.adapter *connection_adapter
    end

    def connection_adapter
      config[:adapter] || :net_http
    end

    # Proxy to Faraday connection which allow to use only accessible request methods.
    #
    #   get("/test/request", foo: "bar")
    #
    self.REQUEST_METHODS.each do |method|
      define_method method do |uri, query|
        connection.send(method, uri, query)
      end
    end

    def base_url
      raise NotImplementedError
    end
  end
end
