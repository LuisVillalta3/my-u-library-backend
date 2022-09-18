class Api::V1::GenresController < ApiController
  rescue_from ActiveRecord::RecordNotFound do |e|
    render_json_error :not_found, :genre_not_found
  end

  rescue_from ActionController::ParameterMissing do |e|
    render_json_error :bad_request, :missing_genre_params
  end

  def index
    page = params[:page] || nil
    limit = params[:rowsPerPage] || nil
    
    return render json: Genre.all if !page || !limit

    paginate(page, limit)
  end

  def paginate(page, limit)
    offset = (page.to_i - 1) * limit.to_i
    @genres = Genre.offset(offset).limit(limit)

    @genres = @genres.where("name LIKE ?", "%#{params[:search]}%") if params[:search]

    render json: {
      rows: @genres,
      total: Genre.count,
    }
  end

  def show
    render json: Genre.find(params[:id])
  end

  def create
    genre = Genre.new(genre_params)

    return render_json_error :unprocessable_entity, :genre_fields_errors, { errors: genre.errors } if !genre.save
    render json: genre, status: :created
  end

  def update
    genre = Genre.find(params[:id])
    return render_json_error :unprocessable_entity, :genre_fields_errors, { errors: genre.errors } if !genre.update(genre_params)
    render json: genre, status: :ok
  end

  def destroy
    genre = Genre.find(params[:id])
    return render_json_error :conflict, :genre_not_deleted if !genre.destroy!
    render json: genre, status: :ok
  end

  private
  def genre_params
    params.require(:genre).permit(:name, :description)
  end
end
