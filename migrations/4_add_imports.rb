Sequel.migration do
  change do
    create_table(:imports) do
      primary_key :id
      Integer :process_id, null: false
      String :hostname, null: false
      Time :created_at, null: false
    end

    alter_table(:torrents) do
      add_column :import_id, Integer
    end

    alter_table(:torrent_stats) do
      add_column :import_id, Integer
    end
  end
end
