class SearchesController < ApplicationController

  def search
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:werd])
      @books = []
    elsif @range == "Book"
      @books = Book.looks(params[:search], params[:werd])
      @users = []
    elsif @range == "Tag"
      @books = Book.tag_looks(params[:werd])
      @users = []
    end
  end
end

