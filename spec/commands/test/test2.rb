# frozen_string_literal: true

require "rubot"

command = Rubot.client.add_command(:name => "test") do
  puts "Running!"
end
