class Follow<ActiveRecord::Base
    
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
    
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validates :follower_id, uniqueness: { scope: :followed_id, message: "You are already following this user" }
  validate :cannot_follow_self
  
  private
  
  # Custom validation to prevent self-following
  def cannot_follow_self
    errors.add(:followed_id, "You cannot follow yourself") if follower_id == followed_id
  end
end
  