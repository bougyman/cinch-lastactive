require 'cinch'
require 'cinch/toolbox'

module Cinch::Plugins
  class LastActive
    include Cinch::Plugin

    listen_to :join, method: :join_respond
    listen_to :channel, method: :update_time

    def initialize(*args)
      super
      @time = Time.now
    end

    def join_respond(m)
      return if m.user.nick == @bot.nick
      m.reply "Hello, #{m.user.nick}. The last activity was #{time_passed} ago."
    end

    def update_time(m)
      @time = Time.now
    end

    private

    def time_passed
      Cinch::Toolbox.time_format(Time.now - @time)
    end
  end
end
