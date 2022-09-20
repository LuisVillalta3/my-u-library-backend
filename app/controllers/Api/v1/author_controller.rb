class Api::V1::AuthorController < ApiController
  rescue_from ActiveRecord::RecordNotFound do |e|
    render_json_error :not_found, :author_not_found
  end

  rescue_from ActionController::ParameterMissing do |e|
    render_json_error :bad_request, :missing_author_params
  end

  def index
    page = params[:page] || nil
    limit = params[:rowsPerPage] || nil
    
    return render json: Author.all if !page || !limit

    paginate(page, limit)
  end

  def paginate(page, limit)
    offset = (page.to_i - 1) * limit.to_i
    @authors = Author.offset(offset).limit(limit)

    @authors = @authors.where("firstName ILIKE ?", "%#{params[:firstName]}%") if params[:firstName].present?
    @authors = @authors.where("last_name LIKE ?", "%#{params[:lastName]}%") if params[:lastName]

    render json: {
      rows: @authors,
      total: Author.count,
    }
  end

  def show
    render json: Author.find(params[:id])
  end

  def create
    author = Author.new(author_params)

    return render_json_error :unprocessable_entity, :author_fields_errors, { errors: author.errors } if !author.save
    render json: author, status: :created
  end

  def update
    author = Author.find(params[:id])
    return render_json_error :unprocessable_entity, :author_fields_errors, { errors: author.errors } if !author.update(author_params)
    render json: author, status: :ok
  end

  def destroy
    author = Author.find(params[:id])
    return render_json_error :conflict, :author_not_deleted if !author.destroy!
    render json: author, status: :ok
  end

  private
  def author_params
    params.require(:author).permit(:first_name, :last_name, :nacionality, :birthday)
  end
end
