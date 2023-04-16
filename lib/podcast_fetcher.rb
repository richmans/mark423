require 'net/http'
require 'rexml/document'

class ParsedItem
  attr_accessor :title
  attr_accessor :guid
  attr_accessor :description
  attr_accessor :audio_url
  attr_accessor :bytes
  attr_accessor :category
  attr_accessor :publication_date
  attr_accessor :duration
  attr_accessor :author
  attr_accessor :explicit
end

class ParsedPodcast
  attr_accessor :title
  attr_accessor :description
  attr_accessor :link
  attr_accessor :language
  attr_accessor :copyright
  attr_accessor :author
  attr_accessor :email
  attr_accessor :image_url
  attr_accessor :explicit
  attr_accessor :category
  attr_accessor :keywords
  attr_accessor :items
  def initialize
    @items = []
  end
end

class PodcastFetcher
  def fetch(url)
    xml = fetch_url(url)
    parse_xml(xml)
  end

  def fetch_url(url)
    uri = URI(url)
    if uri.scheme == 'http' || uri.scheme == 'https'
      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = 1
      http.max_retries = 5
      http.use_ssl = uri.scheme == 'https'
      response = http.request(Net::HTTP::Get.new(uri.path))
      data = response.body
    elsif uri.scheme == 'file'
      data = File.read(uri.path)
    else
      raise "Invalid uri scheme"
    end
    data
  end

  def parse_xml(xml)
    doc = REXML::Document.new(xml)
    p = ParsedPodcast.new
    c = doc.root.get_elements("channel").first
    p.title = c.get_text("title").to_s.strip
    p.description = c.get_text("description").to_s.strip
    p.link = c.get_text("link").to_s
    p.language = c.get_text("language").to_s
    p.copyright = c.get_text("copyright").to_s
    p.author = c.get_text("itunes:author").to_s
    p.email = c.get_text("itunes:owner/itunes:email").to_s
    p.image_url = c.get_elements("itunes:image").first.attributes["href"]
    p.explicit = c.get_text("itunes:explicit").to_s.downcase == 'yes'
    p.keywords = c.get_elements("item/itunes:keywords").first.get_text.to_s
    p.category = {}
    c.get_elements("itunes:category").each do |cat|
      cat_name = cat.attributes['text']
      p.category[cat_name] = []
      cat.get_elements("itunes:category").each do |subcat|
        subcat_name = subcat.attributes['text']
        p.category[cat_name].append(subcat_name)
      end
    end
    
    c.get_elements("item").each do | e |
      p.items.append(parse_item(e))
    end
    p
  end

  def parse_item(e)
    i = ParsedItem.new()
    i.title = e.get_text("title").to_s
    i.guid = e.get_text("guid").to_s.strip
    i.description = e.get_text('description').to_s.strip
    i.publication_date = e.get_text('pubDate').to_s
    i.duration = e.get_text('duration').to_s
    i.bytes = e.get_elements('enclosure').first.attributes['length'].to_i
    i.author = e.get_text('itunes:author').to_s
    i.explicit = e.get_text('itunes:explicit').to_s.downcase == 'yes'
    i.audio_url = e.get_elements('enclosure').first.attributes['url']
    i  
  end
end