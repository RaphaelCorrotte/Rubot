# frozen_string_literal: true

require_relative "../../../lib/rubot"

command = Rubot.client.add_command(:name => "test") do
  puts "Running!"
end
