# frozen_string_literal: true

require_relative "rubot/version"
require File.expand_path("rubot/classes/client", File.dirname(__FILE__))

module Rubot
  def self.client
    @client ||= Rubot::Client.new
  end
end
