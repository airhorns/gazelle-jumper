#!/usr/bin/env bash
set -ex
sqlite3 -header -csv $1 "SELECT torrents.created_at, torrents.name, torrents.format, torrents.artist_name, torrent_stats.seeders, torrent_stats.leechers, torrent_stats.snatches, CAST(strftime('%s', torrents.created_at) as integer) - CAST(strftime('%s', torrent_stats.created_at) as integer) as \"age\" FROM torrents LEFT JOIN torrent_stats ON torrent_stats.id = torrents.id"  > "$(basename $1).csv"
