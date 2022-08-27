# frozen_string_literal: true

require "discordrb"
require "dotenv/load"
require File.expand_path("manager", File.dirname(__FILE__))
require File.expand_path("command", File.dirname(__FILE__))
require File.expand_path("event", File.dirname(__FILE__))
require File.expand_path("rapplication_command", File.dirname(__FILE__))

module Rubot
  class Client < Discordrb::Bot
    attr_reader :commands, :events, :rapplication_commands

    def initialize
      super(:token => ENV["BOT_TOKEN"], :intents => :all, :ignore_bots => true)
    end

    def run(background = false)
      @events.each(&:run)
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

    def add_application_command(command:, subcommand: nil, group: nil, proprieties: nil, &block)
      @rapplication_commands ||= Array[]
      command = RApplicationCommand.new(self, :command => command, :subcommand => subcommand, :group => group, :props => proprieties, &block)
      command.create
      @rapplication_commands << command
    end

    def remove_application_commands
      get_application_commands.map(&:id).each do |id|
        delete_application_command(id)
      end
      @rapplication_commands = Array[]
    end
  end
end
