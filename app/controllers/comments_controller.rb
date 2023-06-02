class CommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = Comment.new
    comment = current_user.comments.new(book_comment_params)
    comment.book_id = @book.id
    comment.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    Comment.find(params[:id]).destroy
    flash[:notice] = "Comment was successfully destroy."
  end

  private

  def book_comment_params
    params.require(:comment).permit(:comment, :book_id)
  end

end
