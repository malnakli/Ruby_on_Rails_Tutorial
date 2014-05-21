class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    # This code uses respond_to to take the appropriate action depending on the kind of request. 
    # In the case of an Ajax request, Rails automatically calls a JavaScript Embedded Ruby 
    #v(.js.erb) file with the same name as the action, i.e., create.js.erb 
    respond_to do |format|
          format.html { redirect_to @user }
          format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    # search for rails respond_with, which can be used instead of respond_to 
    respond_to do |format|
          format.html { redirect_to @user }
          format.js
    end
  end
end