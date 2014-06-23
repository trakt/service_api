module ServiceApi
  class UriTokens
    attr_reader :uri_template

    def initialize(*args)
      @uri_template = URITemplate.new(*args)
    end

    def token_values
      @token_values ||= tokens.map(&:variables).flatten
    end

    private

    def tokens
      @tokens ||= @uri_template.tokens.select{ |template| !template.variables.empty? }
    end
  end
end
