# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def self.env_storage
    if Rails.env.production? || ENV["S3_USE"] == 'true'
      :fog
    else
      :file
    end
  end

  storage env_storage

  def store_dir
    if model
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "uploads/images/#{Date.today.strftime("%Y-%m-%d")}"
    end
  end

  def content_type_whitelist
    /image\//
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*args)
    ActionController::Base.helpers.asset_path("default-#{model.class.to_s.underscore}-#{mounted_as}.png")
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  version :xs  do
    process resize_to_fit: [80, nil]
  end

  version :sm do
    process resize_to_fit: [200, nil ]
  end

  version :md do
    process resize_to_fit: [400, nil]
  end

  version :lg do
    process resize_to_fit: [700, nil]
  end

  version :xl do
    process resize_to_fit: [1024, nil]
  end

  def fix_exif_rotation
    manipulate! do |img|
      img.tap(&:auto_orient)
    end
  end
  process :fix_exif_rotation

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  def url(version = nil)
    super_result = super(version)

    if Rails.env.production? || ENV["S3_USE"] == 'true'
      return super_result
    elsif self.model&.read_attribute(self.mounted_as&.to_sym).blank?
      super_result
    else
      if super_result.starts_with?('http://', 'https://')
        super_result
      elsif self.file.try(:exists?) or ENV["S3_BUCKET"].blank?
        ActionController::Base.helpers.asset_url(super_result)
      else
        return "https://#{ENV["S3_BUCKET"]}.s3.amazonaws.com#{super_result}"
      end
    end
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    if model
      "#{secure_token(10)}.#{file.extension}" if original_filename.present?
    else
      super
    end
  end

  protected

  def secure_token(length=16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
  end
end
