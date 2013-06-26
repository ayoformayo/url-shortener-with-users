class Url < ActiveRecord::Base
  before_create :generate_tiny_url

  def generate_tiny_url
    chars = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a
    loop do
      self.tiny_url = ''
      
      4.times do
        self.tiny_url = tiny_url + chars.sample
      end
      p 'testing: ' + tiny_url
      break unless Url.find_by_tiny_url(tiny_url)
    end

    p 'using: ' + tiny_url
  end

end
