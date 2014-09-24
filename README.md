# Slack::Cap
  Hooks before / after deploy tasks and notifies Slack about the deployment start and finish.

  The output looks like this:

     Jon Doe / MyAwesomeApp's master / production - started - fixing that nasty bug...
     Jon Doe / MyAwesomeApp's master / production - finished - 31 seconds.


## Installation

    # In Gemfile:
    gem 'slack-cap'

    # then run:
    $ bundle


## Usage

    # in your Capfile
    require 'slack-cap'

    # in your config/deploy.rb
    set :slack_app,      'MyAwesomeApp'
    set :slack_team,     'my-subdomain-on-slack.com'
    set :slack_token,    'XXXXXXXXXXXX'
    set :slack_channel,  '#deployments'

    # optional param, defaults to 'capistrano'
    set :slack_username, 'capistrano'


    # deployment
    $ MSG='fixing that nasty bug...' cap production deploy


## Contributing

1. Fork it ( https://github.com/[my-github-username]/slack-cap/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
