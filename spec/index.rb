# frozen_string_literal: true

require "dotenv/load"
require "discordrb"
require "rubot"

client = Rubot.client
manager = Rubot::Manager.new("spec/commands", "spec/events")
client.remove_application_commands
manager.load
Rubot.client.events.each do |event|
  p event[1].run
end
client.run
