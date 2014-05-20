class Micropost < ActiveRecord::Base
    belongs_to :user
    default_scope -> { order('created_at DESC') }
    # the length of content cannot exceed 140
      validates :content, presence: true, length: { maximum: 140 }
    validates :user_id, presence: true
end
