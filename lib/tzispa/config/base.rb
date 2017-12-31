# frozen_string_literal: true

require 'ostruct'

module Tzispa
  module Config

    class Base < Struct
      def self.parametrize(params)
        new(*params&.keys&.map(&:to_sym)).new(*(params&.values&.map do |v|
          v.is_a?(Hash) ? parametrize(v) : v
        end))
      end

      def method_missing(m, *args, &block)
        return if respond_to_missing?(m)
        super
      end

      def respond_to_missing?(_sym, _include_priv)
        true
      end
    end

  end
end
