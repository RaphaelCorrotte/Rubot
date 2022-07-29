# frozen_string_literal: true

require_relative "../../lib/rubot"

Rubot.client.add_event(:name => "ready") do
  puts "HELLO"
end
