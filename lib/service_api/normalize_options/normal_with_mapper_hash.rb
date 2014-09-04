class NormalizeOptions
  class NormalWithMapperHash < NormalizeOptions::Base
    def call
      options.each_with_index do |option, index|
        new_options[mapper[mapper_key[index]]] = option
      end

      new_options
    end

    private

    def mapper_key
      mapper.keys
    end
  end
end