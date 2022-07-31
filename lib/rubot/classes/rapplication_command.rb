# frozen_string_literal: true

require "discordrb"

module Rubot
  class RApplicationCommand
    attr_reader :client, :command, :subcommand, :group, :execute, :props, :id, :default_permissions

    def initialize(client, command:, subcommand: nil, group: nil, props: nil, default_permissions: nil, &block)
      @client = client
      @command = command
      @subcommand = subcommand
      @group = group
      @props = props
      @default_permissions = default_permissions
      @execute = block
    end

    def create
      @client.register_application_command(@command[:name].to_sym, @command[:description]) do |command|
        unless @subcommand
          proprieties(command) if @props
          permissions(command) if @default_permissions
          next
        end

        if @group
          command.group(@group[:name].to_sym, @group[:description]) do |group|
            group.command(@subcommand[:name].to_sym, @subcommand[:description]) do |b|
              proprieties(b) if @props
              permissions(command) if @default_permissions
            end
          end
        else
          command.subcommand(@subcommand[:name].to_sym, @subcommand[:description]) do |b|
            proprieties(b) if @props
            permissions(command) if @default_permissions
          end
        end
      end

      command = @client.application_command(@command[:name].to_sym) do |event|
        @id = event.command_id
        @execute.call(event)
      end

      return unless @subcommand

      command.subcommand(@subcommand[:name].to_sym) do |event|
        @id = event.command_id
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

    def permissions(builder); end

    def application_command
      return nil unless @id

      @client.get_application_command(@id)
    end
  end
end
