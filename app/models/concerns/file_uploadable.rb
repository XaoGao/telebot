# frozen_string_literal: true

require 'faraday'

module FileUploadable
  def upload_attachment(path: path_to_image, file_extend: 'image/jpeg')
    Faraday::FilePart.new(path, file_extend)
  end
end
