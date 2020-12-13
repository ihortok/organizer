class User < ActiveRecord::Base
  AVATAR_SIZES = {
    big: '250x250',
    small: '45x45'
  }.freeze

  has_secure_password
  has_many :tasks

  validates :username, :email, presence: true, uniqueness: true
end
