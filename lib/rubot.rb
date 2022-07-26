# frozen_string_literal: true

require_relative "rubot/version"
require "rubot/classes/client"

module Rubot
  def self.client
    @client ||= Rubot::Client.new
  end
end
