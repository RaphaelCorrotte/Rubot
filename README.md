[![Les Laboratoires Ruby](https://invidget.switchblade.xyz/4P7XcmbDnt)](https://discord.gg/4P7XcmbDnt)

# Rubot

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/Rubot`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'discord_rubot'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install discord_rubot

## Usage

### Install gems
Before starting to use the command handler. You have to figure some gem requirements in your Gemfile : 
```rb
source "https://rubygems.org"

gem 'discord_rubot', "~> 0.1.3"
gem "discordrb", :git => "https://github.com/shardlab/discordrb", :branch => "main"
gem "dotenv"
gem "mongo", "~> 2.18"
```
Then run `bundle updte` and `bundle install` to install the gems. Now you can start using the command handler.

### Setting up the command handler

To create your environment you have 3 things to do. 
First, you have to create a `.env` file where you register your bot token
```dotenv
BOT_TOKEN=<your bot token>
```
Then you have to create your main file where you set up Rubot
```ruby
require "rubot"

client = Rubot.new("<your commands directory>", "<your events directory>")
client.run
```
This simple code load the bot, and set up the commands and events (commands are regular commands and slash commands (known as application_commands)).

Before launching your application you have to create the `commands` and `events` directories.

### Start coding

Now, you can start coding your commands and events.
Register a command and an event is very simple.

```ruby
require "rubot"

Rubot.client.add_command(:ping, "Ping") do |event|
  event.message.respond "Pong"
end
```

This is a command example, The simple commands are not very interesting because the application commands exist.

Now let's see an application_command
```ruby
require "rubot"

Rubot.client.add_application_command(**Hash[
  :command => Hash[:name => "test", :description => "Test a command"],
  :proprieties => [
    Hash[:type => :user, :name => :user, :description => "Who's tested ?", :required => true],
  ]
]) do |event|
  event.respond(:embeds => [Rubot::BetterEmbed.new(:default).description("Test")]) do |_, view|
    view.row do |r|
      r.button(:label => "Test!", :style => :success, :custom_id => "test_button:1")
    end
  end

  Rubot.client.button(:custom_id => /test_button:1/) do |_button_event|
    embed = Rubot::BetterEmbed.new(:success)
    embed.description("Wa")
    event.edit_response(:embeds => [embed])
  end
end
```

This is a simple example. You can add the :subcommand (use it as command) key in your hash to register a subcommand. You can add proprieties. See the discordrb doc.

And now an event example
```ruby
require "rubot"

Rubot.client.add_event(:name => "ready") do
  puts "Ready to use!"
end
```
As simple as that !

Iy you have an issue, create a GitHub issue I'll help you. You can also join the Ruby Lab discord server.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Senchuu/Rubot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/Senchuu/Rubot/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rubot project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Senchuu/Rubot/blob/master/CODE_OF_CONDUCT.md).
