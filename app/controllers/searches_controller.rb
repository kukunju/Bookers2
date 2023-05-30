class SearchesController < ApplicationController

  def search
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search],params[:werd])
    else
      @books = Book.looks(params[:search],params[:werd])
    end
  end

end
