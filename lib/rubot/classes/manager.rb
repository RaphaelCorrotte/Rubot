# frozen_string_literal: true

require "fileutils"

module Rubot
  class Manager
    attr_accessor :application_commands_path, :commands_path, :events_path

    def initialize(application_commands_path:, commands_path: nil, events_path: nil)
      @application_commands_path = application_commands_path
      @commands_path = commands_path
      @events_path = events_path
    end

    def files(path)
      Dir.entries(path).each_with_object([]) do |entry, files|
        next if %w[. ..].include?(entry)

        if Dir.exist?("#{@application_commands_path}/#{entry}")
          files.concat(files("#{path}/#{entry}"))
        else
          files << "#{path}/#{entry}" unless files.include?("#{path}/#{entry}")
        end
      end
    end

    def application_commands_files
      files(@application_commands_path)
    end

    def commands_files
      files(@commands_path) if @commands_path
    end

    def events_files
      files(@events_path) if @events_path
    end

    def load
      application_commands_files.each { |file| Kernel.load file }
      commands_files&.each { |file| Kernel.load file }
      events_files&.each { |file| Kernel.load file }
      true
    end
  end
end
