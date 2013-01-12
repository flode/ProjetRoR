class PublicationsController < ApplicationController

  def index
    @publications = Publication.paginate(page: params[:page])
  end

  def show
    @publication = Publication.find(params[:id])
  end

  def new
    @publication = Publication.new
  end

  def create
    @publication = Publication.new(params[:publication])
    if @publication.save
      flash[:success] = "New publication created!"
      redirect_to @publication
    else
      render 'new'
    end
  end
end
