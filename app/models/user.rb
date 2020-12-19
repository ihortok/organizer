class User < ActiveRecord::Base
  AVATAR_SIZES = {
    small: '50x50',
    big: '150x150'
  }.freeze

  has_secure_password
  has_many :tasks

  validates :username, :email, presence: true, uniqueness: true

  def avatar(size: :small)
    "/uploads/#{File.basename(avatar_path, '.*')}_#{AVATAR_SIZES[size]}#{File.extname(avatar_path)}"
  end
end
