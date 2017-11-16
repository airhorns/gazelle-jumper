Sequel.migration do
  change do
    create_table(:torrent_stats) do
      primary_key :id
      foreign_key :torrent_id, :torrents, null: false
      Integer :snatches, null: false
      Integer :seeders, null: false
      Integer :leechers, null: false
      Integer :size_in_bytes, null: false

      Time :created_at
    end
  end
end
