class StaticPagesController < ApplicationController
  
  def index
    if signed_in?
    @micropost = current_user.microposts.build 
    @feed_items = current_user.feed.paginate(page: params[:page]) # feed is a method defined in user.rb
  end
  end 
  
  def home 
  end 
  
  def help
  end 
  
  def about
  end 
  def contact
  end
end 