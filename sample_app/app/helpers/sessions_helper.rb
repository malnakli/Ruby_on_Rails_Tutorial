module SessionsHelper
  
  def sign_in(user)
     remember_token = User.new_remember_token
     # the following line equal to  cookies[:remember_token] = { value:   remember_token, expires: 20.years.from_now.utc }
     cookies.permanent[:remember_token] = remember_token 
     user.update_attribute(:remember_token, User.digest(remember_token))
     
     #  this code will never actually be used in the present application due to the immediate redirect 
     # but it would be dangerous for the sign_in method to rely on this.
     self.current_user = user
   end
   
     def signed_in?
       !current_user.nil?
     end 
     
     
   #Ruby has a special syntax for defining such an assignment function,
   def current_user=(user)
       @current_user = user
     end
     
     def current_user
       # the user’s signin status would be forgotten: as soon as the user went to another page
       # the session would end and the user would be automatically signed out. 
       # This is due to the stateless nature of HTTP interactions 
       # when the user makes a second request, all the variables get set to their defaults, which for instance variables like 
      # Hence, when a user accesses another page, even on the same application, Rails has set @current_user to nil,
      # To avoid this problem, we can find the user corresponding to the remember token
      
         remember_token = User.digest(cookies[:remember_token]) #because the remember token in the database is hashed
         @current_user ||= User.find_by(remember_token: remember_token) # ||= (“or equals”) means that assigning to a variable if it’s nil but otherwise leaving it alone
      end
      
      def current_user?(user)
         user == current_user
       end
      #change the user’s remember token in the database (in case the cookie has been stolen
      def sign_out
          current_user.update_attribute(:remember_token,
                                        User.digest(User.new_remember_token))
          cookies.delete(:remember_token)
          self.current_user = nil
        end
        
        
        #o store the location of the requested page somewhere, and then redirect to that location instead
        def redirect_back_or(default)
           redirect_to(session[:return_to] || default)
           session.delete(:return_to)
         end

         def store_location
           session[:return_to] = request.url if request.get? # save to return_to session  only for a GET request
         end
end
