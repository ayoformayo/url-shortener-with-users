class CreateUrlsUsers < ActiveRecord::Migration
  def change
    create_table :urls_users do |url_user|
      url_user.integer :user_id
      url_user.integer :url_id
      url_user.timestamps
    end
  end
end
