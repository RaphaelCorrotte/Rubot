# frozen_string_literal: true

require_relative "rubot/version"
require File.expand_path("rubot/classes/client", File.dirname(__FILE__))
require File.expand_path("rubot/utils/better_embed", File.dirname(__FILE__))

module Rubot
  def self.new(application_commands_path:, commands_path: nil, events_path: nil)
    raise "Rubot already initialized. Call Rubot.client to access client." if @client

    @client = Rubot::Client.new(application_commands_path: application_commands_path, commands_path: commands_path, events_path: events_path)
    @client
  end

  # @return [Rubot::Client]
  def self.client
    return @client if @client

    raise "Rubot is not initialized. Call Rubot.new first."
  end
end
