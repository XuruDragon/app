module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end
end

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     Rails.application.secrets[:aws]["key"],
    aws_secret_access_key: Rails.application.secrets[:aws]["secret"],
    region:                'eu-west-1'
  }
  config.fog_directory = 'fleetyards'
end