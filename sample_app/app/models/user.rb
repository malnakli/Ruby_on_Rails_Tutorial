class User < ActiveRecord::Base
  # dependent: :destroy  arranges for the dependent microposts to be destroyed when the user itself is destroyed
  has_many :microposts , dependent: :destroy
  # Since destroying a user should also destroy that user’s relationships,
  # we’ve gone ahead and added dependent: :destroy to the association
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy 
  # To make a followed_users array of users, it would be possible to pull out
  # an array of followed_id attributes and then find the user for each one
  # Rails uses has_many through to make this procedure more convenient.
  #
  # source parameter which explicitly tells Rails that the source of 
  # the followed_users array is the set of followed ids.
  has_many :followed_users, through: :relationships, source: :followed
  # we actually have to include the class name for this association
  # because otherwise Rails would look for a ReverseRelationship class, which doesn’t exist.
  has_many :reverse_relationships, foreign_key: "followed_id",  class_name:  "Relationship", dependent:   :destroy
  # we could actually omit the :source key in this case
  # in the case of a :followers attribute, Rails will singularize “followers” and 
  # automatically look for the foreign key follower_id in this case
  has_many :followers, through: :reverse_relationships, source: :follower
  
  
  
  # validation Users
  
    before_create :create_remember_token
    before_save { self.email = email.downcase } 
    #callback to force Rails to downcase the email attribute before saving the user to the database

    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
    #The expression above does have one weakness, though: it allows invalid addresses such as foo@bar..com 
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness:  {case_sensitive: false }
  
     has_secure_password  # for more info https://github.com/rails/rails/blob/master/activemodel/lib/active_model/secure_password.rb
     validates :password, length: { minimum: 6 }
     
     # users methods
     
     def User.new_remember_token
         SecureRandom.urlsafe_base64
     end

       def User.digest(token)
         Digest::SHA1.hexdigest(token.to_s)
       end
     
       def feed
           # This is preliminary. See "Following users" for the full implementation.
           #The question mark
           # ensures that id is properly escaped before being included in the underlying SQL query, thereby avoiding
           # a serious security hole called SQL injection. The id attribute here is just an integer
           # (i.e., self.id, the unique ID of the user), so there is no danger in this case,
           # but always escaping variables injected into SQL statements is a good habit to cultivate.
           
           # Micropost.where("user_id = ?", self.id) # is equal to "self.microposts"
           Micropost.from_users_followed_by(self)
       end
        
      
      def following?(other_user)
          # find_by return boolean
             self.relationships.find_by(followed_id: other_user.id)
      end

      def follow!(other_user)
             self.relationships.create!(followed_id: other_user.id)
      end
      def unfollow!(other_user)
          relationships.find_by(followed_id: other_user.id).destroy
      end
      
     private
     
       def create_remember_token
         # Create the token.
          self.remember_token = User.digest(User.new_remember_token)
       end
end
