class PostsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_post, only: [ :show, :update, :destroy ]
  before_action :authorize_user!, only: [ :update, :destroy ]



  def index
      posts = Post.all
      render json: posts
  end

  def show
    post = Post.find(params[:id])
    render json: post
  end






  def create
    post = current_user.posts.new(post_params)

      if post.save
        render json: post, status: :created
      else
        render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
      end
  end





  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      render json: post
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end



  def destroy
    post = Post.find(params[:id])
    post.destroy
    head :no_content
  end

private
  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    unless @post.user_id == current_user.id
      render json: { error: "You are not authorized to edit or delete this post" }, status: :forbidden
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, tag_ids: [])
  end
end
