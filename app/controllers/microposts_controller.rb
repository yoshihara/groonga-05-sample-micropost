class MicropostsController < ApplicationController
  before_action :set_micropost, only: [:edit, :update, :destroy]

  # GET /microposts
  # GET /microposts.json
  def index
    @microposts = Micropost.all
  end

  # GET /microposts/new
  def new
    @micropost = Micropost.new
  end

  # GET /microposts/1/edit
  def edit
  end

  # POST /microposts
  # POST /microposts.json
  def create
    @micropost = Micropost.new(micropost_params)

    if @micropost.save
      redirect_to microposts_url, notice: 'Micropost was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /microposts/1
  # PATCH/PUT /microposts/1.json
  def update
    if @micropost.update(micropost_params)
      redirect_to microposts_url, notice: 'Micropost was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    @micropost.destroy
    redirect_to microposts_url, notice: 'Micropost was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_micropost
    @micropost = Micropost.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
