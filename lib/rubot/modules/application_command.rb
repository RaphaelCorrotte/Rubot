# frozen_string_literal: true

require "discordrb"

module Rubot
  module ApplicationCommand
    def add_application_command(command:, subcommand: nil, group: nil, options: ->(option_builder) { option_builder }, &block)
      @application_commands_queue ||= Array[]
      @application_commands_queue << Hash[
        :command => command,
        :subcommand => subcommand,
        :group => group,
        :options => options,
        :run => block
      ]
    end

    def launch_application_commands
      @application_commands_queue.each do |command|
        command.transform_keys!(&:to_sym)
        register_application_command(command[:command][:name].to_s, command[:command][:description].to_s) do |option_builder|
          if command[:subcommand]
            @application_commands_queue.each do |subcommand|
              next unless subcommand[:command][:name] == command[:command][:name] && subcommand[:subcommand]

              option_builder.subcommand(subcommand[:subcommand][:name].to_s, subcommand[:subcommand][:description].to_s) do |sub_option_builder|
                command[:options].call(sub_option_builder)
              end
              @application_commands_queue.delete(subcommand)
            end
          else
            command[:options].call(option_builder)
            @application_commands_queue.delete(command)
          end

          cmd = application_command(command[:command][:name].to_sym) do |event|
            command[:run].call(event) unless command[:subcommand]
          end

          cmd.subcommand(command[:subcommand][:name].to_sym) do |event|
            command[:run].call(event) if command[:subcommand]
          end
        end
      end
    end
  end
end
