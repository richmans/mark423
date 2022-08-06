class Recording < ApplicationRecord
  belongs_to :podcast
  has_one_attached :audio_file
  after_destroy :schedule_render
  after_update :schedule_render
  after_create :schedule_render
  
  def schedule_render
    self.podcast.schedule_render
  end
end
