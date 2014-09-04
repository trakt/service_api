class NormalizeOptions
  class Base
    attr_reader :options, :mapper, :new_options

    def initialize(options, mapper)
      @options = options
      @mapper = mapper
      @new_options = {}
    end
  end
end