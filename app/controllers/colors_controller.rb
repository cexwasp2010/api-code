class ColorsController < ApplicationController
  before_action :authorize_admin_request, only: [:create, :update, :destroy]
  before_action :authorize_request, only: [:show]


  def index
    @colors = Color.all 
    render json: @colors
  end 

	def show
    @color = Color.find(params[:id])
    render json: @color
  end 

  def create
    @color = Color.create!(color_params)
    render json: @color
  end 

  def update
    @color = Color.find(params[:id])
    @color.update(color_params)
    render json: @color
  end 

  def destroy
    @colors = Color.all 
    @color = Color.find(params[:id])
    @color.destroy
    render json: @colors
  end 

  private

  def chirp_params
    params.permit(:name, :color, :pantone, :year)
  end

  def authorize_request
      byebug
    AuthorizationService.new(request.headers).authenticate_request!
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end
end
