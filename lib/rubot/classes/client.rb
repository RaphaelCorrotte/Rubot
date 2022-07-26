# frozen_string_literal: true

require "discordrb"
require "dotenv/load"
require File.expand_path("manager", File.dirname(__FILE__))
require File.expand_path("command", File.dirname(__FILE__))

module Rubot
  class Client < Discordrb::Bot
    attr_reader :commands

    def initialize
      super(:token => ENV["BOT_TOKEN"], :intents => :all, :ignore_bots => true)
    end

    def run(background: false)
      puts "Running bot..."
      super
    end

    def add_command(name:, &block)
      @commands ||= Hash[]
      @commands[name] = block
    end

    def command(name)
      @commands[name] || false
    end
  end
end
