# frozen_string_literal: true

require_relative "../../lib/rubot"

Rubot.client.add_application_command(**Hash[
  :command => Hash[:name => "ee", :description => "dit bonjour"],
  :subcommand => Hash[
    :name => "aaa",
    :description => "AAAAAAAAAAAA"
  ],
  :options => lambda do |option_builder|
    option_builder.string("test", "hello i'm a test")
  end
]) do |event|
  event.respond(:content => "Hello!")
end
