module Slack
  module Cap
    class SlackNotifierWrapper
      attr_accessor :team, :token, :channel, :app, :username

      def initialize(opts)
        @app      = opts.fetch(:app)
        @team     = opts.fetch(:team)
        @token    = opts.fetch(:token)
        @channel  = opts.fetch(:channel)
        @username = opts[:username] ||'capistrano'
      end

      def deployer
        ENV['GIT_AUTHOR_NAME'] || `git config user.name`.chomp
      end

      def reason
        raise "provide a reason with MSG=... !" unless ENV['MSG']
        ENV['MSG']
      end

      def notify(msg, icon_emoji: ':rocket:')
        begin
          notifier.ping(msg, icon_emoji: icon_emoji)
        rescue Net::OpenTimeout, Net::ReadTimeout
          puts Colorize.red("SLACK TIMEOUT")
        end
      end

      def notifier
        @notifier ||= ::Slack::Notifier.new(team, token, channel: channel, username: username)
      end

    end
  end
end