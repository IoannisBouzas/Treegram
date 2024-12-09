class Comment<ActiveRecord::Base

  belongs_to :photo
  belongs_to :user


  validates :text_comment, presence: true
  validates :photo, presence: true
  validates :user, presence: true



end

