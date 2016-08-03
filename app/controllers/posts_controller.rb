class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_to_follow!
    before_action :set_new_post!

    def new 
    end
    
    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id # assign the post to the user who created it.
        respond_to do |f|
            if (@post.save) 
                f.html { redirect_to "", notice: "Post created!" }
                f.js
            else
                f.html { redirect_to "", notice: "Error: Post Not Saved." }
                f.js
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
        respond_to do |format |
            if @post.update(post_params)
                format.html { redirect_to :back, notice: "Post was successfully updated" }
                format.js
            else
                format.html { render 'edit' }
                format.js
            end
        end
    end
    
    def destroy 
        @post = current_user.posts.find(params[:id]) 
        @post.destroy
        respond_to do |format|
            format.html { redirect_to root_path, notice: "Post was successfully deleted." }
            format.js
        end
    end  
      
    private
    def post_params # allows certain data to be passed via form.
        params.require(:post).permit(:user_id, :title, :url, :description, { :tag_tokens => [] })
    end
    
end