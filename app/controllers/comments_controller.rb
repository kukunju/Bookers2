class CommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = current_user.comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to book_path(book.id)
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:notice] = "Comment was successfully destroy."
    redirect_to book_path(params[:book_id])
  end

  private

  def book_comment_params
    params.require(:comment).permit(:comment, :book_id)
  end

end
