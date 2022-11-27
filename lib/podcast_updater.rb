require 'uri'
require 'open-uri'

class PodcastUpdater
  def initialize(podcast_shortname)
    @podcast = Podcast.find_by(shortname: podcast_shortname)
    if @podcast == nil
      @podcast = Podcast.new()
      @podcast.shortname = podcast_shortname
    end
  end

  def attach_file(file_field, url)
    puts "Importing file #{url}"
    uri = URI(url)
    extension = File.extname(uri.path).downcase
    content_type = 'application/octet-stream'
    if extension == '.jpeg' || extension == '.jpg'
      content_type = 'image/jpeg'
    elsif extension == '.png'
      content_type = 'image/png'
    end
    file_field.attach(io: uri.open(), filename: File.basename(uri.path), content_type: content_type)
  end

  def update(parsed_podcast)
    @podcast.name = parsed_podcast.title
    @podcast.description = parsed_podcast.description
    @podcast.language = parsed_podcast.language
    @podcast.copyright = parsed_podcast.copyright
    @podcast.author = parsed_podcast.author
    @podcast.email = parsed_podcast.email
    @podcast.explicit = parsed_podcast.explicit
    @podcast.category = parsed_podcast.category.to_json
    @podcast.keywords = parsed_podcast.keywords
    attach_file(@podcast.image_file, parsed_podcast.image_url)
    save_result = @podcast.save
    if not save_result
      puts "Errors while saving podcast:"
      puts @podcast.errors.full_messages
    end
    parsed_podcast.items.each do | i |
      update_item(i)
    end
  end

  def update_item(i)
    recording = Recording.find_by(guid: i.guid)
    if recording != nil
      return
    end
    filename = File.basename(URI(i.guid).path)
    puts "Importing recording #{i.title}"
    r = Recording.new
    r.filename = filename
    r.theme = i.title
    r.description = i.description
    r.recorded_at = Time.parse(i.publication_date)
    r.speaker = i.author
    r.podcast = @podcast
    r.guid = i.guid
    r.visible = true
    save_result = r.save
    attach_file(r.audio_file, i.audio_url)
    unless save_result
      puts "Could not save item:"
      puts r.errors.full_messages
    end
    
  end
end