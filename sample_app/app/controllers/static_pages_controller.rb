class StaticPagesController < ApplicationController
  
  def index
    @micropost = current_user.microposts.build if signed_in?
    @feed_items = current_user.feed.paginate(page: params[:page]) # feed is a method defined in user.rb
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