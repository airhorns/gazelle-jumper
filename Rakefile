require './environment'

namespace :db do
	desc "Run migrations"
	task :migrate, [:version] do |t, args|
		Sequel.extension :migration
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(DB, "migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(DB, "migrations")
    end
	end
end
