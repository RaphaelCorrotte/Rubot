# frozen_string_literal: true

require_relative "rubot/version"
require File.expand_path("rubot/classes/client", File.dirname(__FILE__))
require File.expand_path("rubot/utils/better_embed", File.dirname(__FILE__))

module Rubot
  def self.new(commands_path, events_path)
    raise "Rubot already initialized. Call Rubot.client to access client." if @client

    @client = Rubot::Client.new
    @manager = Rubot::Manager.new(commands_path, events_path)
    @client.remove_application_commands
    @manager.load
    @client
  end

  # @return [Rubot::Client]
  def self.client
    return @client if @client

    raise "Rubot is not initialized. Call Rubot.new(commands_path, events_path) first."
  end

  # @return [Rubot::Manager]
  def self.manager
    return @manager if @manager

    raise "Rubot is not initialized. Call Rubot.new(commands_path, events_path) first."  end
end
