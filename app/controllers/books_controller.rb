class BooksController < ApplicationController
  before_action :authenticate_user!
  def create
  @book = Book.new(book_params)
  @book.user_id = current_user.id
  if @book.save
    flash[:notice] = "Book was successfully create."
    redirect_to book_path(@book.id)
  else
    @user = User.find(current_user.id)
    @books = Book.all
    render :index
  end
end


  def edit
    @book=Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = @books.user
  end

  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
  end


  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "Book was successfully update."
    redirect_to book_path(@book.id)
    else
      @user = User.find(current_user.id)
    @books = Book.where(user_id: @user.id)
    render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.delete
    flash[:notice] = "Book was successfully destroy."
    redirect_to "/books"
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end


end
