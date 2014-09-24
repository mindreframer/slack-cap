require 'slack-notifier'
require "slack-cap/version"
load File.expand_path("capistrano/tasks/slack.rake", File.dirname(__FILE__))
