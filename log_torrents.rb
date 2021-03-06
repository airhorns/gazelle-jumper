require './environment'
require 'socket'

GazelleAPI = RubyGazelle::Gazelle.connect(
  site: Secrets['gazelle']['site'],
  username: Secrets['gazelle']['username'],
  password: Secrets['gazelle']['password']
)

class Torrent < Sequel::Model
  one_to_many :torrent_stats
end

class TorrentStat < Sequel::Model
  many_to_one :torrent
end

class Import < Sequel::Model
end

def log_once
  current_import = Import.create(
    process_id: Process.pid,
    hostname: Socket.gethostname,
    created_at: Time.now.utc
  )

  groups = Log.time("Fetching 5 pages import_id=#{current_import.id}") do
    (1..1).flat_map do |page|
      GazelleAPI.search(:torrents, order_by: 'time', order_way: 'desc').response.results
    end
  end

  torrent_count = 0
  stat_count = 0

  groups.each do |group|
    next unless group["torrents"]
    group["torrents"].each do |torrent|
      torrent_record = Torrent.where(gazelle_torrent_id: torrent['torrentId']).first
      unless torrent_record
        torrent_record = Torrent.create(
          gazelle_torrent_id: torrent['torrentId'],
          gazelle_group_id: group['groupId'],
          name: "#{group['artist']} - #{group['groupName']}",
          artist_name: group['artist'],
          format: "#{torrent['media']} / #{torrent['format']} / #{torrent['encoding']}",
          gazelle_group_created_at: Time.at(group['groupTime'].to_i).utc,
          gazelle_created_at: DateTime.parse(torrent['time']).to_time.utc,
          size_in_bytes: torrent['size'],
          created_at: Time.now.utc,
          import_id: current_import.id
        )
        torrent_count += 1
      end

      TorrentStat.create(
        torrent_id: torrent_record.id,
        snatches: torrent['snatches'],
        seeders: torrent['seeders'],
        leechers: torrent['leechers'],
        created_at: Time.now.utc,
        import_id: current_import.id
      )
      stat_count += 1
    end
  end

  Log.info "Injest complete torrent_count=#{torrent_count} stat_count=#{stat_count} import_id=#{current_import.id}"
end

log_once
