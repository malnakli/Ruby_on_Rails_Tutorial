module UsersHelper
  
  
=begin
   A Gravatar is a Globally Recognized Avatar. You upload it and create your profile 
   just once, and then when you participate in any     
   Gravatar-enabled site, your Gravatar image will automatically follow you there.
=end
  # Returns the Gravatar (http://gravatar.com/) for the given user.
    def gravatar_for(user)
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
      image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end
end
