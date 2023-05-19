class RecipesController < ApplicationController

    def index
        recipes = Recipe.all
        render json: recipes, include: :user
    end

    def create
        current_user = User.find_by(id: session[:user_id])
        recipe = current_user.recipes.create(recipe_params)
        if recipe.valid?
            render json: recipe, include: :user, status: :created
        else
            render json: {errors: ['Invalid']}, status: :unprocessable_entity
        end
    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

end
