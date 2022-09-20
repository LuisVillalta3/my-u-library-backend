class Api::V1::BooksController < ApiController
  rescue_from ActiveRecord::RecordNotFound do |e|
    render_json_error :not_found, :book_not_found
  end

  rescue_from ActionController::ParameterMissing do |e|
    render_json_error :bad_request, :missing_book_params
  end

  def index
    page = params[:page] || 1
    limit = params[:rowsPerPage] || 10
    offset = (page.to_i - 1) * limit.to_i
    @books = Book.offset(offset).limit(limit)

    @books = @books.where('title ILIKE ?', "%#{params[:title]}%") if params[:title].present?
    @books = @books.where('author_id = ?', params[:author_id].to_i) if params[:author_id].present?
    @books = @books.where('genre_id = ?', params[:genre_id].to_i) if params[:genre_id].present?

    render json: {
      rows: @books.as_json(include: [:author, :genre]),
      total: Book.count,
    }
  end

  def show
    render json: Book.find(params[:id]), include: [:author, :genre, :check_out_requests]
  end

  def create
    book = Book.new(book_params)
    book.available = book.in_stock > 0

    return render_json_error :unprocessable_entity, :book_fields_errors, { errors: book.errors } if !book.save
    render json: book, status: :created
  end

  def update
    book = Book.find(params[:id])
    book.available = book.in_stock > 0
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
