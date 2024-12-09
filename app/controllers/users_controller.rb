class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    @user.valid?
    if !@user.is_email?
      flash[:alert] = "Input a properly formatted email."
      redirect_to :back
    elsif @user.errors.messages[:email] != nil
      flash[:notice]= "That email " + @user.errors.messages[:email].first
      redirect_to :back
    elsif @user.save
      flash[:notice]= "Signup successful. Welcome to the site!"
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:alert] = "There was a problem creating your account. Please try again."
      redirect_to :back
    end
  end

  def new
  end

  def show
    @user = User.find(params[:id])
    @tag = Tag.new
    @comment = Comment.new
    @user_photos = @user.photos.order(created_at: :desc)
    @followed_user_photos = Photo.where(user: @user.followed_users).order(created_at: :desc)
    @users = User.where.not(id: current_user.id)
  end
  

  def follow
    @user = User.find(params[:id])
    begin
      current_user.followed_users << @user unless current_user.followed_users.include?(@user)
      flash[:notice] = "Successfully followed #{@user.email}"
    rescue => e
      flash[:alert] = "Unable to follow user: #{e.message}"
    end
    redirect_to user_path(current_user) # redirect to user page
  end


  def unfollow
    @user = User.find(params[:id])
    begin
      current_user.followed_users.delete(@user)
      flash[:notice] = "Successfully unfollowed #{@user.email}"
    rescue => e
      flash[:alert] = "Unable to unfollow user: #{e.message}"
    end
    redirect_to user_path(current_user) # redirect to user page
  end




  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :avatar)
  end


end
