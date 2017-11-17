require './environment'

lastfm = Lastfm.new(Secrets['last_fm']['api_key'], Secrets['last_fm']['shared_secret'])
lastfm.session = lastfm.auth.get_mobile_session(
  username: Secrets['last_fm']['username'],
  password: Secrets['last_fm']['password']
)['key']

CSV.open("last_fm_artists.csv", 'wb', {
  write_headers: true,
  headers: ['artist', 'playcount', 'listeners']
  }) do |csv|
  (1..10).flat_map do |page|
    lastfm.chart.get_top_artists(page: page).each do |artist|
      csv << artist.values_at("name", "playcount", "listeners")
    end
  end
end

Log.info "Wrote Last.fm artist CSV"
