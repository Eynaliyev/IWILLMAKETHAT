class TagsController < ApplicationController
    
    before_action :set_auth!
    before_action :set_to_follow!


    def index
        @posts = Post.all
        if user_signed_in?
          @newPost = Post.new
          @followers_count = current_user.followers.count
        end
        # setting up code for the tokeninput field
        @tags = Tag.order(:title)
        respond_to do |format|
            format.html
            format.json { render json: @tags.where("title like ?", "%#{params[:q]}%") }

        end
    end

    def new
        @newTag = Tag.new
    end

    def create
        @tag = Tag.new(tag_params)
        respond_to do |f|
            if (@tag.save)
                f.html {redirect_to "/", notice: "Tag created!" }
            else
                f.html {redirect_to "", notice: "Error: Tag not saved."}
            end
        end
    end

    private
    def tag_params # allows certain data to be passed via form.
        params.require(:tag).permit(:title)
    end
    
end
