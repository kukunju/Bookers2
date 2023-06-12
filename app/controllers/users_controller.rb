class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new

    if params[:latest]
      @books = Book.latest.where(user_id: @user.id)
    elsif params[:old]
      @books = Book.old.where(user_id: @user.id)
    elsif params[:star_desc]
      @books = Book.star_desc.where(user_id: @user.id)
    else
      @books = Book.where(user_id: @user.id)
    end


  end

  def index
    @user = User.find(current_user.id)
    @users = User.all
    @book = Book.new
  end

  #followした人一覧
  def follows
    @user = User.find(current_user.id)
    user = User.find(params[:id])
    @users = user.follows
    @book = Book.new
  end

  #followされた人一覧
  def followers
    @user = User.find(current_user.id)
    user = User.find(params[:id])
    @users = user.followers
    @book = Book.new
  end



  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "User_info was successfully update."
    redirect_to user_path(@user.id)
    else
    render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user), notice: 'ゲストユーザーはプロフィール編集画面へ移行できません。'

    end
  end

end
