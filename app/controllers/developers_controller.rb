class DevelopersController < ApplicationController
	def index
		@developers = Developer.all
	end

	def json
		@developers = Developer.all
		response.headers['Cache-Control'] = 'no-cache'
		render :json => @developers
	end

	def new
		
	end

	def create
		@developer = Developer.new(post_params)
		@developer.save
		redirect_to @developer
	end

	def show
		@developer = Developer.find(params[:id])
	end

	private
		def post_params
			params.require(:developer).permit(:name, :surname, :phone)
		end
end
