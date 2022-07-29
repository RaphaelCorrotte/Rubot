# frozen_string_literal: true

require "fileutils"

module Rubot
  class Manager
    attr_accessor :commands_path, :events_path

    def initialize(commands_path, events_path)
      @commands_path = commands_path
      @events_path = events_path
    end

    def files(path)
      files = []
      Dir.entries(path).each do |entry|
        next if %w[. ..].include?(entry)

        if Dir.exist?("#{@commands_path}/#{entry}")
          files.concat(files("#{path}/#{entry}"))
        else
          files << "#{path}/#{entry}" unless files.include?("#{path}/#{entry}")
        end
      end
      files
    end

    def command_files
      files(@commands_path)
    end

    def event_files
      files(@events_path)
    end

    def load
      command_files.each { |file| Kernel.load file }
      event_files.each { |file| Kernel.load file }
      true
    end
  end
end
