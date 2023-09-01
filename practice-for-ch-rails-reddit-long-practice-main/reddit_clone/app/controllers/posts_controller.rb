class PostsController < ApplicationController
    before_action :is_author?, only: [:update, :edit]

    def show
        @post = Post.find_by(id: params[:id])
    end

    def new
    end

    def create
        @post = Post.new(post_params)
        if @post.save
            redirect_to post_url(@post)
        else
            flash.now[:errors]= @post.errors.full_messages
            render :new
        end

    end

    def edit 
        @post = Post.find_by(id: params[:id])
    end

    def update
        @post = Post.find_by(id: params[:id])
        if @post.update(post_params)
            redirect_to post_url(@post)
        else
            flash.now[:errors] = @post.errors.full_messages
            render :edit
        end
    end

    def is_author?
        @user = User.find_by(id: params[:user_id])
        @user.id == @post.author_id
    end

    private

    def post_params
        params.require(:post).permit(:title, :url, :content)
    end
end
