class BugsController < ApplicationController
  def index
    @bugs = Bug.all.order("value, updated_at DESC")
  end
  
  def create
    @bug = Bug.new(bug_params)
    @bug.value = 0
    
    respond_to do |format|
      if @bug.save
        flash[:success] = 'Request was successfully created.'
        format.html { redirect_to(bugs_path) }
      else
        flash[:alert] = 'Could not create Request' 
        format.html { redirect_to(bugs_path)}
      end
    end
  end
  
  def change
    bb = Bug.find(params[:b])
    bb.update(:value => (bb.value + 1)%3)
    redirect_to bugs_path
  end
  
  def destroy
    @bug = Bug.find(params[:id])
    
    @bug.destroy
   
    respond_to do |format|
      format.html { redirect_to bugs_path }
    end
  end
  
  private
  def bug_params
    params.require(:bug).permit(:name, :typ, :text)
  end
end
