class CouncilsController < ApplicationController
  def index
    @councils = Council.all.order("name ASC")
  end
  
  def create
    @council = Council.new(council_params)
    
    respond_to do |format|
      if @council.save
        flash[:success] = 'Fachschaft was successfully created.'
        format.html { redirect_to(councils_path) }
      else
        flash[:alert] = 'Could not create Fachschaft' 
        format.html { redirect_to(councils_path)}
      end
    end
  end
  
  def edit
    @council=Council.find(params[:id])
  end
  
  def update
    @council=Council.find(params[:id])
    @council.update(council_params)
    redirect_to councils_path
  end
  
  def destroy
    @council = Council.find(params[:id])
    @council.destroy

    respond_to do |format|
        format.html{redirect_to(councils_path)}
    end
  end
  
  private
  def council_params
    params.require(:council).permit(:name, :color, :shortcut)
  end
end
