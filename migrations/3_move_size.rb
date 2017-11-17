Sequel.migration do
  change do
    drop_column :torrent_stats, :size_in_bytes
    add_column :torrents, :size_in_bytes, Integer
  end
end
