require 'bundler/setup'
Bundler.require(:default)
require 'logger'
require './gazelle'

if !File.exist?('config/secrets.json')
  raise RuntimeError, "Couldn't boot because decrypted secrets not present next to #{__FILE__}"
end
Secrets = JSON.load(File.open('config/secrets.json'))

DB = Sequel.connect("sqlite://db.sqlite")

Log = Logger.new($stdout)
Log.level = Logger::INFO
Log.datetime_format = "%Y-%m-%d %H:%M:%S"

def Log.time(message, level: Logger::INFO)
  start_time = Time.now.utc
  return_value = yield
  end_time = Time.now.utc
  add(level, "#{message} elapsed=#{(end_time - start_time).round(2)} seconds")
  return_value
end
