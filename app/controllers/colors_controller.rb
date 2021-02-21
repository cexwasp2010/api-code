class ColorsController < ApplicationController
	
  before_action :authorize_request, only: [:show, :create, :update, :destroy]

  def index
    @colors = Color.all 
    render json: @colors
  end 

	def show
    @color = Color.find(params[:id])
    render json: @color
  end 

  def create
    @color = Color.create(
        name: params[:name],
        color: params[:color],
        pantone: params[:pantone],
        year: params[:year]
    )
    render json: @color
  end 

  def update
    @color = Color.find(params[:id])
    @color.update(
        name: params[:name],
        color: params[:color],
        pantone: params[:pantone],
        year: params[:year]
    )
    render json: @color
  end 

  def destroy
    @colors = Color.all 
    @color = Color.find(params[:id])
    byebug
    @color.destroy
    render json: @colors
  end 

  private

    def authorize_request
      AuthorizationService.new(request.headers, action_name).authenticate_request!
    rescue AuthorizationService::TokenError, AuthorizationService::AuthorizationError => e
      render json: { errors: e.message }, status: :unauthorized
    end
end