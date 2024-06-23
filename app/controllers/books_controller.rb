class BooksController < ApplicationController
  
  before_action :authenticate_user!
  # アクセス制限
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def new
   @book = Book.new
#   User info用
   @user = User.find(current_user)
#   Books用(特定のユーザ用), アソシエーション
   @books = current_user.books
  # Books用(Books全部)
   @books_all = Book.all
  # USers用
   @users = User.all
  # Book detail用
   @book_show = Book.find(params[:id])
  end  
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @user = current_user
      @books_all = Book.all
      render 'index'
    end
  end
  
  def show
   @book = Book.new
   @book_show = Book.find(params[:id])
   @user = @book_show.user
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(params[:id])
    else
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  def index
    @book = Book.new
    @user = current_user    
    @books_all = Book.all
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end     
  
  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end
  
end
