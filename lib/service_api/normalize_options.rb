require 'service_api/normalize_options/base'
require 'service_api/normalize_options/hash_with_mapper_hash'
require 'service_api/normalize_options/normal_with_mapper_array'
require 'service_api/normalize_options/normal_with_mapper_hash'

class NormalizeOptions
  attr_reader :mapper, :options

  def initialize(mapper, *options)
    @mapper = mapper
    @options = options
  end

  def call
    if hash_options?
      parse_hash_options
    elsif arguments_count_corrent?
      parse_normal_options
    else
      raise ArgumentError
    end
  end

  private

  def parse_hash_options
    if mapper_hash?
      parse_hash_options_with_mapper_hash
    else
      first_options
    end
  end

  def parse_normal_options
    if mapper_hash?
      parse_normal_options_with_mapper_hash
    elsif mapper_array?
      parse_normal_options_with_mapper_array
    else
      {}
    end
  end

  def parse_hash_options_with_mapper_hash
    NormalizeOptions::HashWithMapperHash.new(first_options, mapper).call
  end

  def parse_normal_options_with_mapper_hash
    NormalizeOptions::NormalWithMapperHash.new(options, mapper).call
  end

  def parse_normal_options_with_mapper_array
    NormalizeOptions::NormalWithMapperArray.new(options, mapper).call
  end

  def mapper_hash?
    mapper.class == Hash
  end

  def mapper_array?
    mapper.class == Array
  end

  def first_options
    @first_options ||= options.first
  end

  def hash_options?
    options.count == 1 && first_options.class == Hash
  end

  def arguments_count_corrent?
    options.count == mapper.count
  end
end