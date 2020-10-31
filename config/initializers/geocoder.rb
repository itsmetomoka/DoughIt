Geocoder.configure(
  lookup: :google,              # name of geocoding service (symbol)
  api_key: ENV['GOOGLE_API'], # API key for geocoding service
  use_https: true,
  timeout: 5,
  units: :km
)