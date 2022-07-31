# frozen_string_literal: true

require "dotenv/load"
require "discordrb"
require "rubot"

client = Rubot.new("spec/commands", "spec/events")
client.run
