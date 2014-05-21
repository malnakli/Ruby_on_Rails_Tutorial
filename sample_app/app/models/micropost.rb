class Micropost < ActiveRecord::Base
    belongs_to :user
    default_scope -> { order('created_at DESC') }
    # the length of content cannot exceed 140
      validates :content, presence: true, length: { maximum: 140 }
    validates :user_id, presence: true
    
    def self.from_users_followed_by(user)
      # followed_users.map(|i| i.id) = followed_user_ids
      # |i| i.id = &:id
      
      # user.followed_user_ids  pulls all the followed users’ ids into memory,
      # and creates an array the full length of the followed users array so we replaced by the below code, to make all the operations done through database server.
        followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
        # the below line is equal to SQL
        # SELECT * FROM microposts WHERE user_id IN (<list of ids>) OR user_id = <user id>
       
        # where("user_id IN (?) OR user_id = ?", followed_user_ids, user)          
        self.where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
                               
       
     
       
        # The question mark syntax is fine, but when we want the same variable inserted in more than one place,
        # the second syntax is more convenient.
        
      end
end
