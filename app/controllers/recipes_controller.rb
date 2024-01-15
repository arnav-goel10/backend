class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    recipes = Recipe.all
    render json: recipes
  end

  def show
    recipe = Recipe.find(params[:id])
    render json: recipe
  end

  def create

    recipe = current_user.recipes.build(recipe_params)
    if recipe.save
      render json: recipe, status: :created
    else
      render json: recipe.errors, status: :unprocessable_entity
    end
  end

  def update
    recipe = Recipe.find(params[:id])
    if recipe.update(recipe_params)
      render json: recipe
    else
      render json: recipe.errors, status: :unprocessable_entity
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    head :no_content
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :description, :instructions)
  end
end
