require 'cinch'
require 'cinch/toolbox'

module Cinch
  module Plugins
    # Cinch Plugin to informing joining users how long ago the last line
    #   of text was spoken.
    class LastActive
      include Cinch::Plugin

      listen_to :join, method: :join_respond
      listen_to :channel, method: :update_time

      def initialize(*args)
        super
        @times = Hash.new(Time.now)
      end

      def join_respond(m)
        return if m.user.nick == @bot.nick
        return if m.channel.nil?
        m.user.reply "Hello, #{m.user.nick}. Welcome to #{m.channel.name}. The last activity was " \
                "#{time_passed(m.channel.name)} ago."
      end

      def update_time(m)
        @times[m.channel.name] = Time.now
      end

      private

      def time_passed(channel)
        Cinch::Toolbox.time_format(Time.now - @times[channel])
      end
    end
  end
end
