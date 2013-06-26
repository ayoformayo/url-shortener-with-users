class Url < ActiveRecord::Base
  before_create :generate_tiny_url

  validate :url_works

  def generate_tiny_url
    chars = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a
    loop do
      self.tiny_url = ''
      
      4.times do
        self.tiny_url = tiny_url + chars.sample
      end
      break unless Url.find_by_tiny_url(tiny_url)
    end
  end

  def url_works
    begin
      open(url)
      #why is ^ not @url
    rescue Errno::ENOENT => e
      p e
      errors.add(:url, 'is teh suck')
    rescue OpenURI::HTTPError => e
      p e
      errors.add(:url, 'HTTP error -- does the page exist?')
    end
  end

end
