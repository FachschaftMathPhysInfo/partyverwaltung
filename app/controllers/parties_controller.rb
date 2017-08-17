class PartiesController < ApplicationController
  def index
    @parties=Party.order('jahr DESC, semester DESC').all
  end

  def create
    @party = Party.new(party_params)
    #check if dummy exists from new app
    @dummy=Party.where("jahr=1337").first
    if @dummy
        @dummy.destroy
        @party.active=true
    else
        @party.active=false
    end
    
    respond_to do |format|
      if @party.save
        flash[:success] = 'Fest was successfully created.'
        format.html { redirect_to(parties_path) }
      else
        flash[:alert] = 'Could not create Fest' 
        format.html { redirect_to(parties_path) }
      end
    end
  end
  
  def activate
    @alle=Party.all
    @alle.each do |f|
      f.update(:active => false)
    end
      
    @fest=Party.find(params[:newid])
    @fest.update(:active => true)
      
    redirect_to parties_path
  end
  
  def copy
    @party=Party.find(params[:goal_id])
    @old=Party.find(params[:copy_party])
    
    @old_sections=Section.where("party_id=#{@old.id}")
    @old_sections.each do |s|
        @new_section =Section.create(:name => s.name, :visible => true, :text => s.text, :party_id => params[:goal_id])
        @old_shifts=Shift.where("section_id = #{s.id}")
        @old_shifts.each do |t|
            Shift.create(:start => t.start, :ende => t.ende, :section_id => @new_section.id)
        end
    end
    flash[:primary] = @old.name + "auf " + @party.name + " kopiert"
    redirect_to parties_path
  end
  
  def destroy
    @fest = Party.find(params[:id])
    
    if @fest.active
      flash[:alert]="Fest aktiv...bitte anderes Fest erst aktivieren"
      redirect_to(parties_path) and return
    end
    @fest.destroy

    respond_to do |format|
      format.html{redirect_to(parties_path)}
    end
  end
  
  private
  def party_params
    params.require(:party).permit(:jahr, :semester, :active)
  end
end
