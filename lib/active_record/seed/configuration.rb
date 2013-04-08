require 'singleton'

module ActiveRecord
  module Seed
    class Configuration
      include Singleton
      attr_accessor :models_dir
      attr_accessor :seeds_dir
      attr_accessor :tables
    end
  end
end
