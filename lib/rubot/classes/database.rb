# frozen_string_literal: true

require "mongo"

module Rubot
  class Database < Mongo::Client
    def initialize(addresses_or_uri, options = nil)
      super
    end

    def ensure(collection, schema)
      c = self[collection]
      c.insert_one(schema)
    end
  end
end
