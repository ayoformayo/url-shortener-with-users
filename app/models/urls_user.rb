class UrlsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :url
  # validates :user_id, :url_id, uniqueness: true
  validates_uniqueness_of :url_id, scope: :user_id
  # validate :user_id_and_url_id_combination_is_unique

  # def user_id_and_url_id_combination_is_unique
  #   p user_id
  #   p url_id
  #   if UrlsUser.find_by_user_id_and_url_id(user_id, url_id)
  #     p 'error!'
  #     errors.add(:urls_user, 'you already have that one!')
  #   end
  # end
end

