class User < ActiveRecord::Base
  
  before_save { self.email = email.downcase } #callback to force Rails to downcase the email attribute before saving the user to the database
  
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
  #The expression above does have one weakness, though: it allows invalid addresses such as foo@bar..com 
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness:  {case_sensitive: false }
  
  
   has_secure_password  # for more info https://github.com/rails/rails/blob/master/activemodel/lib/active_model/secure_password.rb
     validates :password, length: { minimum: 6 }
end
