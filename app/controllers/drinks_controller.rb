class DrinksController < ApplicationController
  before_action :set_drink, only: [:show, :update, :destroy]

  # GET /drinks
  def index
    @drinks = Drink.all
    json_response(@drinks)
  end

  # POST /drinks
  def create
    @drink = Drink.create!(drink_params)
    json_response(@drink, :created)
  end

  # GET /drinks/:id
  def show
    json_response(@drink)
  end

  # PUT /drinks/:id
  def update
    @drink.update(drink_params)
    head :no_content
  end

  # DELETE /drinks/:id
  def destroy
    @drink.destroy
    head :no_content
  end

  private

  def drink_params
    # whitelist params
    params.permit(:title, :description, :steps, :source)
  end

  def set_drink
    @drink = Drink.find(params[:id])
  end


end
