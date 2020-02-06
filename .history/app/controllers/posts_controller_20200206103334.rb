# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to @post
      flash[:notice] = 'Post created!'
    else
      redirect_back(failback_location: root_path)
      flash[:alert] = 'Post creation failed'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to post_path
  end

  private

  def post_params
    params.require(:post).permit(:caption, :pic)
  end
end
