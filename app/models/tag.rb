class Tag<ActiveRecord::Base
  belongs_to :user
  belongs_to :photo

  validates :user_id, uniqueness: { scope: :photo_id, 
  message: "has already been tagged in this photo" }

  
end
