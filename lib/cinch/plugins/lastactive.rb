require 'cinch'
require 'cinch/toolbox'

module Cinch
  module Plugins
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
        m.reply "Hello, #{m.user.nick}. The last activity was " \
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
