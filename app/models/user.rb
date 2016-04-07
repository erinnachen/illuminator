class User < ActiveRecord::Base
  validates :uid,         presence: true, uniqueness: true
  validates :name,        presence: true
  validates :nickname,    presence: true
  validates :avatar,      presence: true
  validates :oauth_token, presence: true

  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid                = auth_info.uid
      new_user.name               = auth_info.extra.raw_info.name
      new_user.nickname           = auth_info.extra.raw_info.login
      new_user.avatar             = auth_info.extra.raw_info.avatar_url
      new_user.oauth_token        = auth_info.credentials.token
    end
  end
end
