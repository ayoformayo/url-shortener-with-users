class User < ActiveRecord::Base
  validates :email, :uniqueness => true
  
  def self.authenticate(email, password)
    begin
      self.find_by_email(email).password == password
    rescue NoMethodError => e
      p e
      return false
    end
  end
end
