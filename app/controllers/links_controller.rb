class LinksController < ApplicationController
  before_action :find_link, only: [:show, :update, :destroy]

  def index
    @links = Link.all
  end

  def show
  end

  def create

  end

  def new

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def val_params
    params.require(:link).permit(:word, :link)
  end

  def find_link
    @link = Link.find(params[:id])
  end
end
