class RecipesController < ApplicationController

	def index
		@recipes = Recipe.paginate(page: params[:page], per_page: 4)
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	def new
		if logged_in?
			@recipe = Recipe.new
		else
			flash[:danger] = "you must be logged in"
			redirect_to '/login'			
		end
	end

	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.chef = current_user
		if @recipe.save
			flash[:success] = "your recipe was created successfully"
			redirect_to recipes_path
		else
			render :new
		end
	end

	def edit
		if logged_in? & (current_user == Recipe.find(params[:id]).chef)
			@recipe = Recipe.find(params[:id])
		else
			redirect_to recipes_path
		end
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
		if logged_in?
			like = Like.create(like: params[:like], chef: Chef.first, recipe: @recipe)
			if like.valid?
				flash[:success] = "your selection was successful"
				redirect_to :back
			else
				flash[:danger] = "you can only like/dislike once"
				redirect_to :back
			end
		else
			flash[:danger] = "you must be logged in"
			redirect_to login_path
		end
	end

	private

		def recipe_params
			params.require(:recipe).permit(:name, :text, :description, :picture)
		end

end