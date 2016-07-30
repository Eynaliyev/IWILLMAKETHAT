class PostsController < ApplicationController
    
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_to_follow!

    def new 
        @newPost = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id # assign the post to the user who created it.
        respond_to do |f|
            if (@post.save) 
                f.html { redirect_to "", notice: "Post created!" }
            else
                f.html { redirect_to "", notice: "Error: Post Not Saved." }
            end
        end
    end

    def show
        posts = Post.all
        @post = posts.find(params[:id])
    end
  
    def edit 
        @post = current_user.posts.find(params[:id]) 
    end
    
    def update
        @post = current_user.posts.find(params[:id]) 

        if @post.update(post_params)
            redirect_to @post
        else
            render 'edit'
        end
    end
    
    def destroy 
        @post = current_user.posts.find(params[:id]) 
        @post.destroy
        redirect_to "/" 
    end    
    private
    def post_params # allows certain data to be passed via form.
        params.require(:post).permit(:user_id, :title, :url, :description)
    end
    
end