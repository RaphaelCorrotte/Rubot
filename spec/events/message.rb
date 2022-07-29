# frozen_string_literal: true

require_relative "../../lib/rubot"

Rubot.client.add_event(:name => "message") do |event|
  event.message.respond("Hello") if event.message.content.downcase.include?("bite")
end
