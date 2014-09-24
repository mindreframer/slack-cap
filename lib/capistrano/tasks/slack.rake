namespace :slack do
  def wrapper
    @wrapper ||= Slack::Cap::SlackNotifierWrapper.new(
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
    start_time = fetch(:start_time)
    elapsed    = Time.now.to_i - start_time.to_i
    msg        = "#{msg_prefix} - finished - #{elapsed} seconds."
    wrapper.notify(msg)
  end

  before 'deploy', 'slack:starting'
  after 'deploy',  'slack:finished'
end
