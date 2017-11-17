# config valid for current version and patch releases of Capistrano
lock "~> 3.10.0"

set :application, "gazelle-jumper"
set :repo_url, "https://github.com/airhorns/gazelle-jumper"
set :deploy_to, "~/gazelle-jumper"
append :linked_dirs, "log"

set :rbenv_type, :user

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
