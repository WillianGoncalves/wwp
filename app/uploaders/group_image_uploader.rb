class GroupImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick unless Figaro.env.cloudinary_url?
  include Cloudinary::CarrierWave if Figaro.env.cloudinary_url?

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  process :convert => 'png'
  process :tags => ['group_image', "env_#{Rails.env}"] if Figaro.env.cloudinary_url?
  process :resize_to_fill => [400, 400]

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

  def extension_whitelist
    %w(jpg jpeg png)
  end

end
