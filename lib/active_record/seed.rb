require 'active_record/seed/version'
require 'active_record/seed/configuration'
require 'active_record/seed/converter'

module ActiveRecord
  module Seed
    class << self
      def config
        @config ||= Configuration.instance
      end

      def configure &block
        yield config
      end

      def target? table
        if config.tables == :all
          true
        elsif config.tables.is_a?(Array) && config.tables.map(&:to_s).include?(table.to_s)
          true
        else
          false
        end
      end
    end
  end
end

require 'active_record/seed/railtie' if defined?(Rails)
