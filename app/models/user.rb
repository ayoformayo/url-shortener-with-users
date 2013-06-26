class User < ActiveRecord::Base
  validates :email, :uniqueness => true
  
  has_many :urls_users
  has_many :urls, :through => :urls_users

  def self.authenticate(email, password)
    begin
      self.find_by_email(email).password == password
    rescue NoMethodError => e
      p e
      return false
    end
  end
end
