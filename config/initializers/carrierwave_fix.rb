module CarrierWave::Uploader::Cache
  MAX_FILENAME_BYTES = 255

  attr_reader :real_original_filename

  private

  def original_filename=(filename)
    raise CarrierWave::InvalidParameter, "invalid filename" if filename =~ CarrierWave::SanitizedFile.sanitize_regexp

    @real_original_filename = filename.unicode_normalize!

    @original_filename = filename
    @original_filename.force_encoding('utf-8')
    @original_filename.encode!("UTF-16BE", "UTF-8", invalid: :replace, undef: :replace, replace: '')
    @original_filename.encode!("UTF-8")
    @original_filename.unicode_normalize!

    if(@original_filename.bytes.length > MAX_FILENAME_BYTES)
      original_file_extension = File.extname(@original_filename)
      @original_filename = @original_filename.mb_chars.limit(MAX_FILENAME_BYTES - original_file_extension.bytes.length).to_s
      @original_filename += original_file_extension
    end
    @original_filename
  end
end

CarrierWave.configure do |config|
  if Rails.env.production? || ENV["S3_USE"] == 'true'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV["S3_ACCESS_KEY"],
      aws_secret_access_key: ENV["S3_SECRET_KEY"],
      region:                ENV["S3_REGION"],
      endpoint:              ENV["S3_END_POINT"]
    }
    config.fog_directory  = ENV["S3_BUCKET"]
    config.fog_public     = true
  else
    config.asset_host = ActionController::Base.asset_host
  end
  config.remove_previously_stored_files_after_update = true
end
