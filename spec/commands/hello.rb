# frozen_string_literal: true

require_relative "../../lib/rubot"

Rubot.client.add_application_command(**Hash[
  :command => Hash[:name => "ee", :description => "dit bonjour"],
  :subcommand => Hash[
    :name => "aaa",
    :description => "AAAAAAAAAAAA"
  ],
  :proprieties => [
    Hash[:type => :user, :name => :bbb, :description => "lol", :required => true],
    Hash[:type => :boolean, :name => :aaa, :description => "lol"]
  ]
]) do |event|
  event.respond(:embeds => [Rubot::BetterEmbed.new(:default).description("Test")]) do |_, view|
    view.row do |r|
      r.button(:label => "Test!", :style => :success, :custom_id => "test_button:1")
    end
  end

  Rubot.client.button(:custom_id => /test_button:1/) do |_button_event|
    embed = Rubot::BetterEmbed.new(:success)
    embed.description("Wa")
    event.edit_response(:embeds => [embed])
  end
end
