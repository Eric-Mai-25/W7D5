class SubsController < ApplicationController
    before_action :is_moderator?, only: [:update, :edit]

    def index
        @subs = Sub.all
    end

    def new
        @sub = Sub.new
    end

    def create
        @sub = Sub.new(sub_params)
        if @sub.save
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :new
        end
    end

    def show
        @sub = Sub.find_by(id: params[:id])
    end
    
    def edit
        @sub = Sub.find_by(id: params[:id])
    end

    def update
        @sub = Sub.find_by(id: params[:id])
        if @sub.update(sub_params)
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :edit
        end
    end

    def is_moderator?
        @user = User.find(id: params[:user_id])
        @user.id == @sub.moderator_id
    end 
    
    def sub_params
        params.require(:sub).permit(:title, :description, :moderator_id)
    end
end
