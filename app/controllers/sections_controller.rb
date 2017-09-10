class SectionsController < ApplicationController
  def index
    @sections=Section.where("party_id = ?",getActiveParty().id).order('name ASC')
    @councils = Council.all.order("name ASC")
  end
  
  def create
    @section = Section.new(section_params)
    @section.visible = true
    @section.party_id = getActiveParty().id
    
    respond_to do |format|
      if @section.save
        flash[:success] = 'Section was successfully created.'
        format.html { redirect_to(sections_path) }
      else
        flash[:alert] = 'Could not create Section' 
        format.html { redirect_to(sections_path)}
      end
    end
  end
  
  def update
    @section = Section.find(params[:id])
    
    respond_to do |format|
      if @section.update_attributes(section_params)
        flash[:success] = 'section was successfully updated.'
        format.html  { redirect_to(@section)}
      else
        flash[:alert] = 'Could not update section'
        format.html { redirect_to (@section)}
      end
    end
  end
  
  def show
    @section=Section.find(params[:id])
    
    #SCHICHTEN
    @shifts = @section.shifts.order("start-interval '8 hours' ASC")#.joins(:council)
    #@shifts=Shift.joins(:council).select("shifts.*, councils.color as color").order("start-interval '8 hours' ASC,council_id,id").where("shifts.section_id=#{@section.id}")
    #BEREICHSLEITER
    bls = @section.section_managers
    @bl = []
    bls.each do |b|
      p = Person.find(b.person_id)
      s = Section.find(b.section_id)
      @bl << [b,s,p]
    end
    
    @bl.sort!{|x,y| x[2].name <=> y[2].name}
    
    
    ######## history stuff
    #saves user ids connected to party
    @histData = {}
    @parties=Party.order('jahr DESC, semester DESC').all #where("id != #{@party_active.id}")
    @parties.each do |p| #cycle through all parties
        #get section by name from these parties
        tmp_section=Section.where("name='#{@section.name}' AND party_id=#{p.id}").first
            #get people from this section
            people_hash={}
            if tmp_section
                tmp_section.shifts.each do |s|
                    if s.person_id
                        tmp_person=Person.find(s.person_id)
                        people_hash[tmp_person.id]=tmp_person.name
                    end
                end
            end
        @histData[p.id] = people_hash
    end
  end
  
  def destroy
    @section = Section.find(params[:id])
    @section.destroy
   
    respond_to do |format|
      format.html { redirect_to(sections_path) }
    end
  end
  
  private
  def section_params
    params.require(:section).permit(:name, :text)
  end
end
