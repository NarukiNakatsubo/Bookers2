class UsersController < ApplicationController
  
  before_action :authenticate_user!
  # アクセス制限
  before_action :is_matching_login_user, only: [:edit, :update]
  
# user edit
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
 
# #  New book
#   def new
#   @book = Book.new
# #   User info用
#   @user = User.find(current_user)
# #   Books用(特定のユーザ用), アソシエーション
#   @books = current_user.books
#   # Books用(Books全部)
#   @books_all = Book.all
#   # USers用
#   @users = User.all
#   # Book detail用
#   @book_show = Book.find(params[:id])
#   end
  
  def show
   @book = Book.new
   @user = User.find(params[:id])
   @books = @user.books
  end
  
  def index
    @book = Book.new
    @user = current_user
    @users = User.all
  end  
    
  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end 
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to current_user
    end
  end

end
