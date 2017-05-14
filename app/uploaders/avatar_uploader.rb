class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  process :convert => 'png'
  process :tags => ['user_avatar', "env_#{Rails.env}"]

  version :standard do
    process :resize_to_fill => [100, 100]
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path('default_avatar.png')
  end

  def public_id
    "#{Rails.env}/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}/#{SecureRandom.hex}"
  end
  
end
