# frozen_string_literal: true

module Rubot
  class BetterEmbed < Discordrb::Webhooks::Embed
    # @param [String] template The template to use for the embed.
    def initialize(template = nil)
      super()
      templates(template.to_sym) if template
    end

    # Returns prebuilt Discordrb::Embed.
    # @return [Discordrb::Embed] The embed.
    def templates(template)
      Hash[
        :default => proc do
          timestamp(Time.at(Time.now.to_i))
          color("ffbc95")
        end,
        :error => proc do
          timestamp(Time.at(Time.now.to_i))
          color("ffbc95")
        end,
        :success => proc do
          timestamp(Time.at(Time.now.to_i))
          color("ffbc95")
        end
      ][template.to_sym].call
    end

    # set the embed's author
    # @param [Discordrb::Webhooks::EmbedAuthor] author The author to set.
    # @return [Discordrb::Webhooks::Embed] The embed object.
    def author(author)
      self.author = author
      self
    end

    # set the embed's description
    # @param [String] description The description to set.
    # @return [Discordrb::Webhooks::Embed] The embed object.
    def description(description)
      self.description = description
      self
    end

    # set the embed's title
    # @param [String] title The title to set.
    # @return [Discordrb::Webhooks::Embed] The embed object.
    def title(title)
      self.title = title
      self
    end

    # set the embed's url
    # @param [String] url The url to set.
    # @return [Discordrb::Webhooks::Embed] The embed object.
    def url(url)
      self.url = url
      self
    end

    # set the embed's color
    # @param [String] color The color to set.
    # @return [Discordrb::Webhooks::Embed] The embed object.
    def color(color)
      self.color = color
      self
    end

    # set the embed's footer
    # @param [Discordrb::Webhooks::EmbedFooter] footer The footer to set.
    # @return [Discordrb::Webhooks::Embed] The embed object.
    def footer(footer)
      self.footer = footer
      self
    end

    # set the embed's timestamp
    # @param [Time] timestamp The timestamp to set.
    # @return [Discordrb::Webhooks::Embed] The embed object.
    def timestamp(timestamp)
      self.timestamp = timestamp
      self
    end

    # set the embed's thumbnail
    # @param [Discordrb::Webhooks::EmbedThumbnail] thumbnail The thumbnail to set.
    # @return [Discordrb::Webhooks::Embed] The embed object.
    def thumbnail(thumbnail)
      self.thumbnail = thumbnail
      self
    end

    # set the embed's image
    # @param [Discordrb::Webhooks::EmbedImage] image The image to set.
    # @return [Discordrb::Webhooks::Embed] The embed object.
    def image(image)
      self.image = image
      self
    end
  end
end
