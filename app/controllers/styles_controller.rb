class StylesController < ApplicationController

	def new
		@style = Style.new
	end

	def create
		@style = Style.new(style_params)
		if @style.save
			flash[:success] = "style was created successfully"
			redirect_to recipes_path
		else
			render 'new'
		end
	end

	def show
		@style = Style.find(params[:id])
		@recipes = @style.recipes.paginate(page: params[:page], per_page: 4)
	end

	private
	
		def style_params
			params.require(:style).permit(:name)
		end

end