# frozen_string_literal: true

require "discordrb"
require "dotenv/load"
require File.expand_path("manager", File.dirname(__FILE__))
require File.expand_path("command", File.dirname(__FILE__))
require File.expand_path("event", File.dirname(__FILE__))
require File.expand_path("../modules/application_command", File.dirname(__FILE__))

module Rubot
  class Client < Discordrb::Bot
    attr_reader :commands, :events, :application_commands_queue, :manager

    include ApplicationCommand
    def initialize(application_commands_path:, commands_path: nil, events_path: nil)
      @manager = Manager.new(application_commands_path: application_commands_path, commands_path: commands_path, events_path: events_path)
      super(:token => ENV["BOT_TOKEN"], :intents => :all, :ignore_bots => true)
    end

    def run(background = false)
      @manager.load
      launch_application_commands
      @events&.each(&:run)
      Thread.new do
        loop do
          stop if $stdin.gets.chomp.downcase.match?(/^\.exit/)
        end
      end
      super(background)
    end

    def add_command(name:, &block)
      @commands ||= Array[]
      @commands <<  Command.new(block, :name => name)
    end

    def add_event(attributes = {}, name:, &block)
      @events ||= Array[]
      @events << Event.new(block, attributes, :name => name)
    end

    def command(name)
      @commands[name] || false
    end

    def event(name)
      @events[name] || false
    end

    def remove_application_commands
      get_application_commands.map(&:id).each do |id|
        delete_application_command(id)
      end
      @application_commands = Array[]
    end
  end
end
