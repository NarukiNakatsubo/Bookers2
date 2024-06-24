class FavoritesController < ApplicationController
  
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    if favorite.save
      if request.referer.include?('users')  # リファラーに'users'が含まれている場合
        redirect_back(fallback_location: user_path(current_user))
      elsif request.referer.include?('books')  # リファラーに'books'が含まれている場合
        redirect_back(fallback_location: books_path)
      else
        redirect_back(fallback_location: book_path(params[:id]))  # それ以外の場合はルートパスにリダイレクト
      end
    end
  end
  
  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    if favorite.destroy
      if request.referer.include?('users')  # リファラーに'users'が含まれている場合
        redirect_back(fallback_location: user_path(current_user))
      elsif request.referer.include?('books')  # リファラーに'books'が含まれている場合
        redirect_back(fallback_location: books_path)
      else
        redirect_back(fallback_location: book_path(params[:id]))  # それ以外の場合はルートパスにリダイレクト
      end
    end
  end
  
end
