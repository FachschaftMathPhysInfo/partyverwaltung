class SectionManagersController < ApplicationController
  def create
    @sectionmanager = SectionManager.new(:section_id => params[:section_id], :person_id => params[:person_id])
    @sectionmanager.save
    
    respond_to do |format|
      if params[:from_person]
        flash[:success] = 'Bereichsleiter eingetrage!'
        format.html { redirect_to person_path(@sectionmanager.person_id) }
      else
        flash[:success] = 'Bereichsleiter eingetrage!'
        format.html { redirect_to section_path(:id => @sectionmanager.section_id) }
      end
    end
  end
  
  def destroy
    @sectionmanager = SectionManager.find(params[:id])
    @person = Person.find(@sectionmanager.person_id)
    @section = Section.find(@sectionmanager.section_id)
    
    @sectionmanager.destroy
   
    respond_to do |format|
      if params[:from_person]
          format.html { redirect_to(@person) }
      else
          format.html { redirect_to(@section) }
      end
    end
  end
  
  private
  def section_manager_params
    params.require(:section_manager).permit(:section_id, :person_id)
  end
end
