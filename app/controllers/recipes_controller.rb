class RecipesController < ApplicationController

	def index
		@recipes = Recipe.all.sort_by{|likes| likes.thumbs_up_total}.reverse
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.chef = Chef.find(2)

		if @recipe.save
			flash[:success] = "your recipe was created successfully"
			redirect_to recipes_path
		else
			render :new
		end
	end

	def edit
		@recipe = Recipe.find(params[:id])
	end

	def update
		@recipe = Recipe.find(params[:id])
		if @recipe.update(recipe_params)
			flash[:success] = "your recipe was updated successfully"
			redirect_to recipe_path(@recipe)
		else
			render :edit
		end
	end

	def like
		@recipe = Recipe.find(params[:id])
		like = Like.create(like: params[:like], chef: Chef.first, recipe: @recipe)
		if like.valid?
			flash[:success] = "your selection was successful"
			redirect_to :back
		else
			flash[:danger] = "you can only like/dislike once"
			redirect_to :back
		end
	end

	private

		def recipe_params
			params.require(:recipe).permit(:name, :text, :description, :picture)
		end

end