require 'slack-notifier'

require "slack-cap/version"
require "slack-cap/colorize"
require "slack-cap/slack_notifier_wrapper"

load File.expand_path("capistrano/tasks/slack.rake", File.dirname(__FILE__))
