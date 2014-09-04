class NormalizeOptions
  class NormalWithMapperArray < NormalizeOptions::Base
    def call
      options.each_with_index do |option, index|
        new_options[mapper[index]] = option
      end

      new_options
    end
  end
end