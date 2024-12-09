class PhotosController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    if params[:photo] == nil

      flash[:alert] = "Please upload a photo"
      redirect_to :back
    else
      @photo = Photo.new(photo_params)
      @photo.user_id = @user.id
      if @photo.save
        flash[:notice] = "Successfully uploaded a photo"
        redirect_to user_path(@user)
      else
        flash[:alert] = "Error uploading photo"
        render :new
      end
    end
  end


  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      @photo.tags.destroy_all
      @photo.comments.destroy_all
      flash[:notice] = 'Photo was successfully deleted.'
    else
      flash[:alert] = 'There was an error deleting the photo.'
    end
    redirect_to user_path(session[:user_id])
  end


  def new
    @user = User.find(params[:user_id])
    @photo = Photo.create()
  end

  private
  def photo_params
    params.require(:photo).permit(:image, :title)
  end
end

