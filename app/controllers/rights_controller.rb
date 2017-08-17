class RightsController < ApplicationController
  def index
    #@alle=Right.all.order('level DESC')
    @alle=Right.all.order('nick ASC')
  end
  
  def create
    @Right = Right.new(right_params)
    
    respond_to do |format|
      if @Right.save
        flash[:success] = 'Recht gegeben'
        format.html { redirect_to(rights_path) }
      else
        flash[:alert] = 'Could not create Recht' 
        format.html { redirect_to(new_right_path)}
      end
    end
  end
  
  def change
    Right.find(params[:r]).update(:level => params[:v])
    redirect_to rights_path
  end
  
  def destroy
    @right = Right.find(params[:id])
    @right.destroy

    respond_to do |format|
        format.html{redirect_to(rights_path)}
    end
  end
  
  private
  def right_params
    params.require(:right).permit(:nick, :level)
  end
end
