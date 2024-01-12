class PostsController < ApplicationController
  #before_action :authenticate_user!, only: [:create]  #
  # Enforce authentication for create action

  def create
    post = current_user.posts.build(post_params)  # Associate post with current user

    if post.save
      render json: post, status: :created
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :desc)  # Exclude user_id as it's set from current_user
  end
end
