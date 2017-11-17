# config valid for current version and patch releases of Capistrano
lock "~> 3.10.0"

set :application, "gazelle-jumper"
set :repo_url, "https://github.com/airhorns/gazelle-jumper"
set :deploy_to, "~/gazelle-jumper"
append :linked_dirs, "log"
set :default_env, { 'EJSON_KEYDIR' => '~/.ejson/keys' }

set :rbenv_type, :user

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
set :whenever_roles, -> { :central_runner }

set :migration_role, :central_runner

set :ejson_file, "config/secrets.ejson"
set :ejson_output_file, "config/secrets.json"
