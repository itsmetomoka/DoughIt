CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIA35AOOM4PTYAQ7SER',
      aws_secret_access_key: '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',
      region: 'ap-northeast-1'
    }

    config.fog_directory  = 'pf-doughit'
    config.cache_storage = :fog
end

=begin
unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['AWS_REGION']
    }

    config.fog_directory  = ENV['AWS_BUCKET_NAME']
    config.cache_storage = :fog
  end
end
=end