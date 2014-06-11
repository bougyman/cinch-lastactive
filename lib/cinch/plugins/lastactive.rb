require 'cinch'
require 'cinch/toolbox'

module Cinch::Plugins
    class LastActive
      include Cinch::Plugin

      listen_to :join, method: :join_respond
      listen_to :channel, method: :update_time

      def initialize(*args)
        @time = Time.now
      end

      def join_respond(m)
        m.reply "Hello, #{m.user.nick}. The last activity was #{time_passed}."
      end

      def update_time(m)
        @time = Time.now
        debug 'TIME'
      end

      private

      def time_passed
        Cinch::Toolbox.time_format(@time - Time.now)
      end
    end
  end
end
