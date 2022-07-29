# frozen_string_literal: true

require "discordrb"

module Rubot
  class ApplicationCommand
    attr_reader :client, :command, :subcommand, :group, :execute, :props

    def initialize(client, command:, subcommand: nil, group: nil, props: nil, &block)
      @client = client
      @command = command
      @subcommand = subcommand
      @group = group
      @props = props
      @execute = block
    end

    def create
      @client.register_application_command(@command[:name].to_sym, @command[:description]) do |command|
        @builder = command
        unless @subcommand
          proprieties(command) if @props
          next
        end

        if @group
          command.group(@group[:name].to_sym, @group[:description]) do |group|
            group.command(@subcommand[:name].to_sym, @subcommand[:description]) { |b| proprieties(b) if @props }
          end
        else
          command.subcommand(@subcommand[:name].to_sym, @subcommand[:description]) { |b| proprieties(b) if @props }
        end
      end

      command = @client.application_command(@command[:name].to_sym) do |event|
        @execute.call(event)
      end

      return unless @subcommand

      command.subcommand(@subcommand[:name]) do |event|
        @execute.call(event)
      end
    end

    def proprieties(builder)
      attributes = %i[boolean integer channel number role string user]
      @props.each do |prop|
        next unless attributes.include?(prop[:type])

        builder.method(prop[:type].to_sym).parameters.each do |type, name|
          raise "Missing required key #{name} in #{prop[:type]} propriety" if type == :req && !prop.key?(name)
        end

        builder.method(prop.delete(:type)).call(prop.delete(:name), prop.delete(:description), **prop)
      end
    end
  end
end
