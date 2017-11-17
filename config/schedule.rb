set :output, "~/gazelle-jumper/shared/log/cron_log.log"

job_type :rbenv_command, %Q{export PATH=/home/deploy/.rbenv/shims:/home/deploy/.rbenv/bin:/usr/bin:$PATH; eval "$(rbenv init -)"; \
                         cd :path && :environment_variable=:environment :bundle_command :task :output }

every 5.minutes do
  rbenv_command "ruby log_torrents.rb"
end

every 1.day do
  rbenv_command "ruby refresh_lastfm.rb"
end
