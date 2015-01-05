class User < ActiveRecord::Base
  validates :user_name, :email, :password_digest, :neighborhood, presence: true
  has_many :posts, dependent: :destroy
  has_many :pets, dependent: :destroy
  has_many :comments, dependent: :destroy

  def authenticate(login_password)
	existing_password = BCrypt::Password.new(self.password_digest)
	if existing_password == login_password
	  return true
	else
	  return false
	end
  end
end

  