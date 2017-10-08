class IngredientsController < ApplicationController

	def new 
		@ingredient = Ingredient.new
	end

	def create
		@ingredient = Ingredient.new(ing_params)
		if @ingredient.save
			flash[:success] = "ingredient was created successfully"
			redirect_to recipes_path
		else
			render 'new'
		end
	end

	def show
		@ingredient = Ingredient.find(params[:id])
		@recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 4)
	end

	private

		def ing_params
			params.require(:ingredient).permit(:name)
		end 
end