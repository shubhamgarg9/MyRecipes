class LoginsController < ApplicationController

	def new

	end

	def create
		chef = Chef.find_by(email: params[:email])
		if chef && chef.authenticate(params[:password])
			session[:chef_id] = chef.id
			flash[:success] = "you are logged in"
			redirect_to recipes_path
		else
			flash.now[:danger] = "your email or password do not match"
			render 'new'
		end
	end

	def destroy
		session[:chef_id] = nil
		flash[:success] = "you have logged out"
		redirect_to root_path
	end

end