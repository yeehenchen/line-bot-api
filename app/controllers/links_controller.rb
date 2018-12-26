class LinksController < ApplicationController
  before_action :find_link, only: [:show, :update, :destroy]

  def index
    @links = Link.all
  end

  def show
  end

  def create
    @link = Link.new(val_params)

    if @link.save
      redirect_to links_path
    else
      render :new
    end
  end

  def new
    @link = Link.new
  end

  def edit

  end

  def update

  end

  def destroy
    @link.destroy
    redirect_to links_path
  end

  private

  def val_params
    params.require(:link).permit(:word, :link)
  end

  def find_link
    @link = Link.find(params[:id])
  end
end
