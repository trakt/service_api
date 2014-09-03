require 'faraday'
require 'faraday_middleware'
require 'uri_template'
require 'queryparams'

module ServiceApi
  # BaseFaraday is module for Faraday api which should be included in own base Api class.
  #
  #   class MyApi
  #     include BaseApi
  #
  #     private
  #
  #     def base_url
  #       'http://example.com'
  #     end
  #   end
  #
  module BaseFaraday
    # Initilizer require config hash as parameter
    #
    #   MyApi.new(config)
    #
    def initialize(config)
      @config = config
      @params = {}
    end

    protected

    # Available get, head, delete, post, put and patch method with path
    # parameter. This method must be call as last method
    #
    #   path('/test/request').params(sample: true, api_key: 'abcd').get
    #
    %w[get head delete post put patch].each do |method|
      define_method method do
        connection.send(method, uri, query_params)
      end
    end

    # Pass path to request
    #
    #   path('/test/request')
    #
    def path(path)
      uri_tokens(path)
      self
    end

    # Pass parameters to request
    #
    #   params(sample: true, api_key: 'abcd')
    #
    def params(options)
      @params = options
      self
    end

    # Last method called in chain which return full url request
    #
    #  path('/test/request').params(sample: true, api_key: 'abcd').url
    #
    def url
      "#{base_url}#{uri}#{query_params_formatted}"
    end

    private

    def connection
      @connection ||= Faraday.new(url: base_url) do |builder|
        builder.response :xml,  content_type: /\bxml$/
        builder.response :json, content_type: /\bjson$/

        if @config[:adapter] == :test
          builder.adapter @config[:adapter], @config[:adapter_options]
        else
          builder.adapter @config[:adapter] || :net_http
        end
      end
    end

    def token?(value)
      uri_tokens.token_values.include?(value.to_s)
    end

    def uri_tokens(uri = nil)
      if uri
        @uri_tokens = ServiceApi::UriTokens.new(uri_kind, uri)
      else
        @uri_tokens
      end
    end

    def uri
      uri_tokens.uri_template.expand(@params)
    end

    def query_params
      @params.reject{ |request_params| token?(request_params) }
    end

    def query_params_formatted
      params = query_params
      params.empty? ? '' : "?#{QueryParams.encode(params)}"
    end

    def uri_kind
      :default
    end

    def base_url
      raise NotImplementedError
    end
  end
end
