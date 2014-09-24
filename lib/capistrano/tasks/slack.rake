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
    raise "provice a reason with MSG=... !" unless ENV['MSG']
    ENV['MSG']
  end

  def notify(msg, icon_emoji: ':rocket:')
    notifier.ping(msg, icon_emoji: icon_emoji)
  end

  def notifier
    @notifier ||= ::Slack::Notifier.new(team, token, channel: channel, username: username)
  end
end


namespace :slack do
  def wrapper
    @wrapper ||= SlackNotifierWrapper.new(
      app:      fetch(:slack_app),
      team:     fetch(:slack_team),
      token:    fetch(:slack_token),
      channel:  fetch(:slack_channe),
      username: fetch(:slack_username),
    )
  end

  def msg_prefix
    deployer   = wrapper.deployer
    app        = wrapper.app
    branch     = fetch(:branch, nil)
    stage      = fetch(:stage, 'production')
    app_string = branch ? "#{app}'s #{branch}" : app


    "#{deployer} / #{app_string} / #{stage}"
  end

  task :starting do
    msg = "#{msg_prefix} - started - #{wrapper.reason}"

    wrapper.notify(msg)
    set(:start_time, Time.now)
  end

  task :finished do
    begin
      start_time = fetch(:start_time)
      elapsed    = Time.now.to_i - start_time.to_i
      msg        = "#{msg_prefix} - finished - #{elapsed} seconds."
      wrapper.notify(msg)
    end
  end

  before 'deploy', 'slack:starting'
  after 'deploy',  'slack:finished'
end
