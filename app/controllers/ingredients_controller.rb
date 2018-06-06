class IngredientsController < ApiController
  before_action :set_drink
  before_action :set_ingredient, only: [:show, :update, :destroy]

  # GET /drinks/:drink_id/ingredients
  def index
    json_response(@drink.ingredients)
  end

  # GET /drinks/:drink_id/ingredients/:id
  def show
    json_response(@ingredient)
  end

  # POST /drinks/:drink_id/ingredients
  def create
    @drink.ingredients.create!(ingredient_params)
    json_response(@drink, :created)
  end

  # PUT /drinks/:drink_id/ingredients/:id
  def update
    @ingredient.update(ingredient_params)
    head :no_content
  end

  # DELETE /drinks/:drink_id/ingredients/:id
  def destroy
    @ingredient.destroy
    head :no_content
  end

  private

  def ingredient_params
    params.permit(:description)
  end

  def set_drink
    @drink = Drink.find(params[:drink_id])
  end

  def set_ingredient
    @ingredient = @drink.ingredients.find_by!(id: params[:id]) if @drink
  end

end
