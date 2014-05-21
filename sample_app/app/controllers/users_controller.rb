class UsersController < ApplicationController
 
  # the filter takes place before particular controller actions
  before_action :signed_in_user, only: [:edit, :update , :index , :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  
  def following
      @title = "Following"
      @user = User.find(params[:id])
      @users = @user.followed_users.paginate(page: params[:page])
      render 'show_follow'
    end

    def followers
      @title = "Followers"
      @user = User.find(params[:id])
      @users = @user.followers.paginate(page: params[:page])
      render 'show_follow'
    end
 
 
    # default methods
 
  def index
    # ere the :page parameter comes from params[:page], which is generated automatically by will_paginate in index.html.erb
        @users = User.paginate(page: params[:page])
  end
    
  def new
        @user = User.new
  end
  
  def show
     @user = User.find(params[:id])
     @microposts = @user.microposts.paginate(page: params[:page])
  end 
  
  def create
      @user = User.new(user_params)    # Not the final implementation!
      
      if @user.save
        # Handle a successful save.
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
          redirect_to @user
      else
        render 'new'
      end
  end
  
  def edit
      @user = User.find(params[:id])
  end
  
  def update
        @user = User.find(params[:id])
        # Note the use of user_params in the call to update_attributes, which uses strong parameters 
        # to prevent mass assignment vulnerability
        # The reason is that initializing the entire params hash is extremely dangerous—it arranges to pass to User.update_attributes all data submitted by a user
        if @user.update_attributes(user_params)
          # Handle a successful update.
          flash[:success] = "Profile updated"
          redirect_to @user
        else
          render 'edit'
        end
    end
      def destroy
        user_id = params[:id]
          User.find(user_id).destroy
          flash[:success] = "User #{user_id} deleted."
          redirect_to users_url
      end
  
  private
=begin
    /users/17?admin=1
    This request would make user 17 an admin,
    which would be a potentially serious security breach, to say the least.
    Because of this danger, it is essential to pass parameters 
    that have been processed to permit only safe-to-edit attributes.
    As noted in Section 7.3.2, this is accomplished using strong parameters
    by calling require and permit on the params hash:
=end
     def user_params
       params.require(:user).permit(:name, :email, :password,
                                    :password_confirmation)
     end
     
     
         
        def correct_user
        # since this code will call when a user do edit or update action, these action will have params[:id] pass to.
            @user = User.find(params[:id]) 
            redirect_to(root_url) unless current_user?(@user)
        end
        
        def admin_user
              redirect_to(root_url) unless current_user.admin?
            end
end
