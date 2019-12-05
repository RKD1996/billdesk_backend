class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates :mobile, uniqueness: true
  validates :password_digest, presence: true

  def password_salt
    self[:password_salt] = BCrypt::Engine.generate_salt
  end
  def password_digest=(password_digest)
    password_salt
    self[:password_digest] = JWT.encode password_digest, self[:password_salt], 'HS256'
  end
end
