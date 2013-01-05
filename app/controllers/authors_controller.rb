class AuthorsController < ApplicationController
  def index
    @authors = Author.paginate(page: params[:page])
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(params[:author])
    @author.user_id = current_user.id
    if @author.save
      flash[:success] = "New author created!"
      redirect_to @author
    else
      render 'new'
    end
  end

  def show
  
  end
end
