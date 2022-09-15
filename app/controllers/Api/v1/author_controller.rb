class Api::V1::AuthorController < ApplicationController
  def index
    render json: Author.all
  end

  def show
    render json: Author.find(params[:id])
  end

  def create
    author = Author.new(author_params)

    return render json: author.errors, status: :unprocessable_entity if !author.save
    render json: author, status: :created
  end

  def update
    author = Author.find(params[:id])
    return render json: author.errors, status: :unprocessable_entity if !author.update(author_params)
    render json: author, status: :ok
  end

  def destroy
    author = Author.find(params[:id])
    return render json: author.errors, status: :unprocessable_entity if !author.destroy
    render json: author, status: :ok
  end

  private
  def author_params
    params.require(:author).permit(:firstName, :lastName, :nacionality, :birthday)
  end
end
