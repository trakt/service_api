class NormalizeOptions
  class HashWithMapperHash < NormalizeOptions::Base
    def call
      mapper.each do |from, to|
        new_options[to.to_sym] = options[from.to_sym]
      end

      new_options
    end
  end
end