# frozen_string_literal: true

require File.expand_path("../lib/rubot", File.dirname(__FILE__))

RSpec.describe Rubot do
  it "has a version number" do
    expect(Rubot::VERSION).not_to be nil
  end

  it "client works" do
    client = Rubot::Client.new
    expect(client).to be_a(Rubot::Client)
  end

  it "manager works" do
    manager = Rubot::Manager.new("spec/commands", "spec/events")
    manager.command_files.each do |file|
      load file
    end
    expect(Rubot.client.commands).to be_an(Hash)
  end
end
