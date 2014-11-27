class MicropostsController < ApplicationController
  before_action :set_micropost, only: [:edit, :update, :destroy]

  def index
    @microposts = Micropost.all
    @search_title = ""
  end

  def new
    @micropost = Micropost.new
  end

  def edit
  end

  def create
    @micropost = Micropost.new(micropost_params)

    if @micropost.save
      redirect_to microposts_url, notice: 'Micropost was successfully created.'
    else
      render :new
    end
  end

  def update
    if @micropost.update(micropost_params)
      redirect_to microposts_url, notice: 'Micropost was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @micropost.destroy
    redirect_to microposts_url, notice: 'Micropost was successfully destroyed.'
  end

  def search
    query = params[:q]
    @microposts = MicropostIndex.search(query)
    @search_title = "(Searched by \"#{query}\")" unless query.blank?

    render :index
  end

  private

  def set_micropost
    @micropost = Micropost.find(params[:id])
  end

  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
