require 'fileutils'
module RssCacheHelper
  def get_local_path(filename)
    local_storage = Rails.application.config.local_storage
    if not  File.directory?(local_storage)
      FileUtils.mkpath local_storage
    end
    local_file = File.join(local_storage, filename)
  end
  module_function :get_local_path
end