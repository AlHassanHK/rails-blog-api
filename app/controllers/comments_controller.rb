class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [ :update, :destroy ]
  before_action :authorize_comment_user!, only: [ :update, :destroy ]

  def create
    comment = @post.comments.new(comment_params)  # Create a comment associated with the post
    comment.user_id = current_user.id  # Set the user_id to the current logged-in user

    if comment.save
      render json: comment, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def set_post
    @post = Post.find(params[:post_id])  # Find the post using the post_id from the URL
  end

  def set_comment
    @comment = @post.comments.find(params[:id])  # Find the comment within the post
  end

  def authorize_user!
    unless @comment.user_id == current_user.id  # Ensure the user is authorized to modify their own comment
      render json: { error: "You are not authorized to edit or delete this comment" }, status: :forbidden
    end
  end


  def comment_params
    params.require(:comment).permit(:body)
  end
end
