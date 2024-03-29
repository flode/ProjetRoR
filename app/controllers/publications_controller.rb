class PublicationsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :edit, :update]
  before_filter :correct_user, only: [:edit, :update]

  def index
    @publications = Publication.paginate(page: params[:page])
  end

  def show
    @publication = Publication.find(params[:id])
    @correct_user_publication = correct_user_publication
  end

  def new
    @publication = Publication.new
    @authors = Author.all
  end

  def create
    @publication = Publication.new(params[:publication])
    @authors = Author.all
    if @publication.save
      flash[:success] = "New publication created!"
      redirect_to @publication
    else
      render 'new'
    end
  end

  def edit
    @publication = Publication.find(params[:id])
    @authors = Author.all
  end

  def update
    @publication = Publication.find(params[:id])
    @authors = Author.all
    if @publication.update_attributes(params[:publication])
      flash[:success] = "Publication updated"
      redirect_to @publication
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
      redirect_to(publication_path(@publication)) unless correct_user_publication
    end

    def correct_user_publication
      @publication = Publication.find(params[:id])
      @publication.authors.each do |f|
        return true if current_user != nil && current_user.id == f.user.id
      end
      return false
    end
end
