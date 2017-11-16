Sequel.migration do
  change do
    create_table(:torrents) do
      primary_key :id
      Integer :gazelle_torrent_id, null: false, index: true
      Integer :gazelle_group_id, null: false
      String :name, null: false
      String :artist_name, null: true
      String :format, null: true

      Time :gazelle_created_at
      Time :gazelle_group_created_at
      Time :created_at
    end
  end
end
