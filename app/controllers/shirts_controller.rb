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
    puts "HAHAHHA"
    puts params[:style]
    send_data(@shirt.photo.file_contents(params[:style]),
                :filename => ( params[:style]== "original" ? @shirt.name+File.extname(@shirt.photo_file_name) : @shirt.name+".png"),
                :type => ( params[:style]== "original" ? @shirt.photo_content_type : "image/png"),
                :disposition => "attachment")
  end
  
  def getImage
    @shirt = Shirt.find(params[:id])
    #@photo = Photo.where("shirt_id=? AND style=?",@shirt.id,style).first 
    send_data(@shirt.photo.file_contents(params[:style]),
                :filename => @shirt.photo_file_name,
                :type => params[:style]== "original" ? @shirt.photo_content_type : "image/png",
                :disposition => "inline")
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
