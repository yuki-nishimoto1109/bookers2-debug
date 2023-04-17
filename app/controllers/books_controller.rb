class BooksController < ApplicationController

  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @mybook = Book.find(params[:id])
    @user = @mybook.user
    @book = Book.new()
    @comment = BookComment.new()
  end

  def index
    @book = Book.new()
    time_range = (Time.now - 7.day)..Time.now
    @books = Book.all
                 .left_joins(:favorites).group(:id)
                 .select('books.*,COUNT("favorites"."id") as favorites_count')
                 .where(favorites: {created_at: time_range})
                 .order(favorites_count: :DESC)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "You have destroyed book successfully."
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end

end
