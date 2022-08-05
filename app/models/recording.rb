class Recording < ApplicationRecord
  belongs_to :podcast
  has_one_attached :audio_file
end
