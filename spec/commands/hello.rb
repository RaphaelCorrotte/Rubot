# frozen_string_literal: true

require "rubot"

Rubot.client.add_command(:name => "hello") do
  puts "Running!"
end
