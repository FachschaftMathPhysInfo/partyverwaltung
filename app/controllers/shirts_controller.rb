class ShirtsController < ApplicationController
  def index
    @shirts=Shirt.all.order('jahr DESC, semester DESC')
  end
  
  def create
    @shirt=Shirt.new(shirt_params)
    
    respond_to do |format|
      if @shirt.save
        flash[:success] = 'Shirt was successfully created.'
        format.html { redirect_to(shirts_path) }
      else
        flash[:alert] = 'Could not create Shirt' 
        format.html { redirect_to(shirts_path)}
      end
    end
  end
  def update
    @shirt=Shirt.find(params[:id])
    
    respond_to do |format|
      if @shirt.update(shirt_params)
          flash[:success] = 'Shirt was successfully updated.'
          format.html  { redirect_to(shirts_path)}
      else
          flash[:alert] = 'Could not update Shirt'
          format.html { redirect_to (shirts_path)}
      end
    end
  end
  
  def download
    @shirt=Shirt.find(params[:id])
    
    send_file(@shirt.photo.path(params[:what]), disposition: 'attachment')
  end
  
  def destroy
    @shirt = Shirt.find(params[:id])
    @shirt.photo=nil
    @shirt.save
    @shirt.destroy
   
    respond_to do |format|
      format.html { redirect_to(shirts_path) }
    end
  end
  
  private
  def shirt_params
    params.require(:shirt).permit(:jahr, :semester, :motto, :photo)
  end
end
