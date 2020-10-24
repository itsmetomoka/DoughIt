CarrierWave.configure do |config|

  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'アクセスキー',
    aws_secret_access_key: 'シークレットキー',
    region: 'ap-northeast-1'

  }  

  config.fog_directory  = 'S3のバケット名'
  config.asset_host = 'https://S3のバケット名.s3.amazonaws.com'
  config.cache_storage = :fog
  config.fog_provider = 'fog/aws'

end