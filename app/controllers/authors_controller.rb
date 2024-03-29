class AuthorsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :edit, :update]
  before_filter :correct_user, only: [:edit, :update]

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
    @author = Author.find(params[:id])
  end

  def edit
    @author = Author.find(params[:id])
    @users = User.all
  end

  def update
    @author = Author.find(params[:id])
    @users = User.all
    if @author.update_attributes(params[:author])
      flash[:success] = "Author updated"
      redirect_to @author
    else
      render 'edit'
    end
  end

  private
    def signed_in_user
      store_location
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @author = Author.find(params[:id])
      redirect_to(author_path(@author)) unless current_user != nil && current_user.id == @author.user.id
    end
end
