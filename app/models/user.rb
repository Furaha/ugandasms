class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
