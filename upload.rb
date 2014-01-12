require 'dotenv'
require 's3_uploader'
require 'excon'

Excon.ssl_verify_peer = false

Dotenv.load

S3Uploader.upload_directory('dist', ENV['S3_BUCKET'], {
  :public => true,
  :region => 'ap-southeast-2',
  :threads => 40
})
