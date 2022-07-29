# frozen_string_literal: true

require "rubot"

RSpec.describe Rubot do
  it "has a version number" do
    expect(Rubot::VERSION).not_to be nil
  end

  it "client works" do
    client = Rubot::Client.new
    expect(client).to be_a(Rubot::Client)
  end

  it "application commands" do
    client = Rubot.client
    manager = Rubot::Manager.new("spec/commands", "spec/events")
    client.remove_application_commands
    manager.load
    Rubot.client.events.each do |event|
      p event[1].run
    end
    client.run
  end
end
