class Api::V1::BooksController < ApiController
  rescue_from ActiveRecord::RecordNotFound do |e|
    render_json_error :not_found, :book_not_found
  end

  rescue_from ActionController::ParameterMissing do |e|
    render_json_error :bad_request, :missing_book_params
  end

  def index
    render json: Book.all
  end

  def show
    render json: Book.find(params[:id])
  end

  def create
    book = Book.new(book_params)

    return render_json_error :unprocessable_entity, :book_fields_errors, { errors: book.errors } if !book.save
    render json: book, status: :created
  end

  def update
    book = Book.find(params[:id])
    return render_json_error :unprocessable_entity, :book_fields_errors, { errors: book.errors } if !book.update(book_params)
    render json: book, status: :ok
  end

  def destroy
    book = Book.find(params[:id])
    return render_json_error :conflict, :book_not_deleted if !book.destroy!
    render json: book, status: :ok
  end

  private
  def book_params
    params.require(:book).permit(:title, :author_id, :genre_id, :published_date, :in_stock, :available)
  end
end