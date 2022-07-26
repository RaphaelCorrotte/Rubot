# frozen_string_literal: true

module Rubot
  class Command
    attr_reader :props, :execute

    def initialize(name:, &execute)
      @props = Hash[:name => name]
      @execute = execute
    end

    def [](prop)
      @props[prop.to_sym]
    end

    def []=(prop, value)
      @props[prop.to_sym] = value
    end

    def method_missing(symbol, *_args)
      @props[symbol] || super
    end

    def respond_to_missing?(symbol, _include_private = false)
      !!@props[symbol] || super
    end
  end
end
