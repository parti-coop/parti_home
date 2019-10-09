class AttachmentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    uploader = ImageUploader.new
    uploader.store!(params[:file].tempfile)
    render json: { filename: uploader.url }.to_json
  end
end