#
class User < ActiveRecord::Base
  before_save { self.role ||= :member }
  before_save { self.email = email.downcase }

  before_create :generate_auth_token

  # Verifies email address format, i.e. name@domain.com
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  # Note: if: 'password_digest.nil?' validates case of new user and if they
  # have entered a password.
  validates :password, presence: true, length: { minimum: 6 }, if: 'password_digest.nil?'
  # Note: The following validation ensures that when updating a user's password,
  # the updated password is also six characters long.
  # allow_blank: true skips the validation if no updated password is given. This
  # allows us to change other attributes on a user without being forced to set
  # the password.
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 100 },
            format: { with: EMAIL_REGEX }

  # Note: has_secure_password "adds methods to set and authenticate against a
  # BCrypt password. This mechanism requires you to have a password_digest
  # attribute."  has_secure_password requires a password_digest attribute on the
  # model it is applied to. has_secure_password creates two virtual attributes,
  # password and password_confirmation that we use to set and save the password.
  has_secure_password

  enum role: [:member, :admin]

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def generate_auth_token
    loop do
      self.auth_token = SecureRandom.base64(64)
      break unless User.find_by(auth_token: auth_token)
    end
  end
end
