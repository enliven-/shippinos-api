class ShipRequestsController < ApplicationController
  before_action :set_ship_request, only: [:show, :update, :destroy]

  # GET /ship_requests
  # GET /ship_requests.json
  def index
    @ship_requests = ShipRequest.all

    render json: @ship_requests
  end

  # GET /ship_requests/1
  # GET /ship_requests/1.json
  def show
    render json: @ship_request
  end

  # POST /ship_requests
  # POST /ship_requests.json
  def create
    @ship_request = ShipRequest.new(ship_request_params)

    if @ship_request.save
      render json: @ship_request, status: :created, location: @ship_request
    else
      render json: @ship_request.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ship_requests/1
  # PATCH/PUT /ship_requests/1.json
  def update
    @ship_request = ShipRequest.find(params[:id])

    if @ship_request.update(ship_request_params)
      head :no_content
    else
      render json: @ship_request.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ship_requests/1
  # DELETE /ship_requests/1.json
  def destroy
    @ship_request.destroy

    head :no_content
  end

  private

    def set_ship_request
      @ship_request = ShipRequest.find(params[:id])
    end

    def ship_request_params
      params[:ship_request]
    end
end
