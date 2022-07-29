# frozen_string_literal: true

require_relative "../../lib/rubot"

Rubot.client.add_application_command(
  :command => Hash[:name => "ee", :description => "dit bonjour"],
  :subcommand => Hash[
                      :name => "aaa",
                      :description => "AAAAAAAAAAAA"
  ],
  :proprieties => [
    Hash[:type => :user, :name => :bbb, :description => "lol", :required => true],
    Hash[:type => :boolean, :name => :aaa, :description => "lol"]
  ]
) do |event|
  event.respond(:content => event.options.to_s)
end
