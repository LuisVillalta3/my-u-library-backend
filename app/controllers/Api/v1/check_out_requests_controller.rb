class Api::V1::CheckOutRequestsController < ApiController
  rescue_from ActiveRecord::RecordNotFound do |e|
    render_json_error :not_found, :genre_not_found
  end

  rescue_from ActionController::ParameterMissing do |e|
    render_json_error :bad_request, :missing_genre_params
  end

  def index
    page = params[:page] || 1
    limit = params[:rowsPerPage] || 10
    offset = (page.to_i - 1) * limit.to_i
    @checkOutRequests = CheckOutRequest.offset(offset).limit(limit)

    @checkOutRequests = @checkOutRequests.where('user_id = ?', params[:user_id].to_i) if params[:user_id].present?
    @total = CheckOutRequest.count
    @total = CheckOutRequest.where('user_id = ?', params[:user_id].to_i).count if params[:user_id].present?

    render json: {
      rows: @checkOutRequests.as_json(include: [:book, :user, :request_status]),
      total: @total,
    }
  end

  def create
    check_out_request = CheckOutRequest.new(check_out_request_params)
    check_out_request.request_status = RequestStatus.find_by_code('borrowed')
    book = Book.find(check_out_request.book_id)
    book_qty = book.in_stock.to_i - 1

    if check_out_request.save && book.update(in_stock: book_qty)
      render json: check_out_request, status: :created
    else
      render_json_error :unprocessable_entity, :check_out_request_fields_errors, { errors: check_out_request.errors }
    end
  end

  def update
    @id = params[:id]
    check_out_request = CheckOutRequest.find(@id)
    check_out_request.request_status = RequestStatus.find_by_code('returned')
    book = Book.find(check_out_request.book_id)
    book_qty = book.in_stock.to_i + 1

    if check_out_request.save && book.update(in_stock: book_qty)
      render json: check_out_request, status: :ok
    else
      render_json_error :unprocessable_entity, :check_out_request_fields_errors, { errors: check_out_request.errors }
    end
  end

  private
  def check_out_request_params
    params.require(:check_out_request).permit(:user_id, :book_id)
  end
end
