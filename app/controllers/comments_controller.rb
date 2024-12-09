class CommentsController < ApplicationController
    def create
      @comment = current_user.comments.build(comment_params)
      
      if @comment.save
        flash[:notice]= 'Comment posted successfully!'
        redirect_to user_path(current_user)
      else
        flash[:alert]= 'Error posting comment.'
        redirect_to user_path(current_user)
      end
    end
  
  
  

    def destroy
      
      @comment = Comment.find(params[:id])
    
      # Only allow deletion by comment owner or photo owner
      if @comment.user == current_user || @comment.photo.user == current_user
        @comment.destroy
        flash[:notice]= 'Comment deleted successfully!'
        redirect_to user_path(current_user)
      else
        flash[:alert]= 'You are not authorized to delete this comment.'
        redirect_to user_path(current_user)
      end
    end



    private
    
    def comment_params
      params.require(:comment).permit(:text_comment, :photo_id)
    end
end