class SimpleDevelopersController < ApplicationController
  def index
    @developers = Developer.all
  end

  def json
    @developers = Developer.all
    response.headers['Cache-Control'] = 'no-cache'
    render :json => @developers
  end

  def update
    developer = Developer.find(params[:id])
    developer.update(name: params[:name],surname: params[:surname], phone: params[:phone], level: params[:level])
    render :json => developer
  end

  def destroy
    developer = Developer.find(params[:id])
    developer.destroy
  end

  def new
    
  end

  def create
    developer = Developer.new(post_params)
    developer.save
    render :json => developer
  end

  def show
    @developer = Developer.find(params[:id])
  end

  private
    def post_params
      params.require(:developer).permit(:name, :surname, :phone, :level)
    end
end
