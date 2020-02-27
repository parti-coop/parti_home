# encoding: utf-8

class DocumentUploader < CarrierWave::Uploader::Base
  def self.env_storage
    if Rails.env.production? || ENV["S3_USE"] == 'true'
      :fog
    else
      :file
    end
  end

  storage env_storage

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "#{secure_token(10)}.#{file.extension}" if original_filename.present?
  end

  before :cache, :save_original_filename
  def save_original_filename(file)
    if real_original_filename and model.respond_to?(:"#{mounted_as}_name")
      model.send(:"#{mounted_as}_name=", real_original_filename)
    end
  end

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

  protected

  def secure_token(length=16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
  end
end
