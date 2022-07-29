# frozen_string_literal: true

require "discordrb"

module Rubot
  class Event
    attr_reader :name, :execute, :attributes

    def initialize(execute, attributes = {}, name:)
      @name = name
      @attributes = attributes
      @execute = execute
    end

    def run
      raise "Unknown event #{@name}" unless Rubot.client.method(@name.to_sym)

      Rubot.client.send(@name) do |event|
        @execute.call(event)
      end
    end
  end
end
