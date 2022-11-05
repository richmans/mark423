class Recording < ApplicationRecord
  belongs_to :podcast, touch: true
  has_one_attached :audio_file
  has_one_attached :image_file do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  before_create :set_filename
  before_update :set_filename
  before_update :set_published
  before_create :set_published
  scope :published, -> { where(published: true) }
  after_touch :maybe_publish

  def maybe_publish
    was_published = self.published
    self.set_published
    if was_published != self.published
      self.save
      if self.published
        PublicationMailer.publication(self).deliver
      end
      return true
    end
    false
  end

  def set_published
    was_published = self.published
    
    self.published = self.not_published_because().length == 0
    if not was_published and self.published
      PublicationMailer.publication(self).deliver_later
    end
  end

  def not_published_because
    reasons = []
    if self.visible != true
      reasons << I18n.t("not_published_because_not_visible")
    end
    if self.speaker.blank?
      reasons << I18n.t("not_published_because_no_speaker")
    end
    if self.theme.blank?
      reasons << I18n.t("not_published_because_no_theme")
    end
    if not self.audio_file.attached?
      reasons << I18n.t("not_published_because_no_audio")
    elsif not self.audio_file.analyzed?
      reasons << I18n.t("not_published_because_audio_not_analyzed")
    end
    logger.info("REASONS: " + reasons.to_s)
    reasons
  end

  def set_filename
    self.filename = get_filename()
    if self.audio_file.attached?
      self.audio_file.blob.update(filename: filename)
    end
  end

  def get_filename()
    uncounted_filename  = speaker[0..20].parameterize + "-" unless speaker.nil?
    uncounted_filename += theme[0..30].parameterize + "-" unless theme.nil?
    uncounted_filename += recorded_at.strftime("%Y%m%d")
    new_filename = uncounted_filename
    counter = 1
    while Recording.where(filename: new_filename).where.not(id: id).any? do
      counter += 1
      new_filename = "#{uncounted_filename}-#{counter}"
    end
    new_filename
  end

  def audio_link
    self.podcast.dir + self.filename + '.mp3'
  end

  def image_link
    self.podcast.dir + self.filename + '.jpg'
  end

  def duration
    return nil unless self.publishable
    return self.audio_file.metadata['duration']
  end

  def publishable
    return self.audio_file.attached? && self.audio_file.analyzed?
  end
  
  def schedule_render
    self.podcast.schedule_render
  end
end
