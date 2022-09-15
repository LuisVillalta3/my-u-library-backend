class Api::V1::AuthorController < ApplicationController
  def index
    render json: Author.all
  end
end
