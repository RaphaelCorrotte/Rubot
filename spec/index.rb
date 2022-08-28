# frozen_string_literal: true

require "dotenv/load"
require "discordrb"
require "rubot"

ENV["BOT_TOKEN"] = "NzQwODczMDMzOTE2MzUwNTY2.GmqVPm.p_aTaZ3ekLTle2JfLqqq4O3QgQDQCigK7lXoYY"
client = Rubot.new(application_commands_path: "spec/commands/")
client.run
