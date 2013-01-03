class AuthorsController < ApplicationController
  def index
    @authors = Author.paginate(page: params[:page])
  end
end
