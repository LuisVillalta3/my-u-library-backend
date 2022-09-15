class Api::V1::AuthorController < ApiController
  rescue_from ActiveRecord::RecordNotFound do |e|
    render_json_error :not_found, :author_not_found
  end

  rescue_from ActionController::ParameterMissing do |e|
    render_json_error :bad_request, :missing_author_params
  end

  def index
    render json: Author.all
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
    params.require(:author).permit(:firstName, :lastName, :nacionality, :birthday)
  end
end
