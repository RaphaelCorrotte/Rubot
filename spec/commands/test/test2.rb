# frozen_string_literal: true

require_relative "../../../lib/rubot"

Rubot.client.add_application_command(**Hash[
  :command => Hash[:name => "test", :description => "Test something"],
  :proprieties => [
    Hash[:type => :user, :name => :tested_user, :description => "Who is tested ?", :required => true]
  ]
]) do |event|
  p event.options["tested_user"]
  event.respond(:content => "Hello #{event.server.members.find { |usr| usr.id == event.options["tested_user"].to_i }.username}")
  event.channel.send_message("Wha")
end
