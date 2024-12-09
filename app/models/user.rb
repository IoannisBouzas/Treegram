class User<ActiveRecord::Base
  has_many :photos
  has_many :tags
  has_many :comments
  

  # Users that this user is following
  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :active_follows, source: :followed
  
  # Users that are following this user
  has_many :passive_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower


  attr_accessor :password
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_confirmation_of :password
  before_save :encrypt_password
  validates :email, uniqueness: true

  validates :email, :presence => true
  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  def is_email?
    self.email.include?('@') && self.email.include?('.')
  end

  def following?(other_user)
    followed_users.include?(other_user)
  end

  def self.authenticate(email, password)
    user = User.where(email: email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
end
