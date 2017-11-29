class ShiftsController < ApplicationController
  def create
    @section = Section.find(params[:section_id])
    for i in 1..params[:counter].to_i
      s = Shift.new(shift_params)
      s.section_id = params[:section_id]
      s.save!
    end
    
    respond_to do |format|
      flash[:success] = 'Schicht was successfully created.'
      format.html { redirect_to(@section) }
    end
  end
  
  def update
    @shift = Shift.find(params[:id])
    @shift.update(shift_params)
    if params.has_key?(:council_id)
      @shift.update(:council_id => params[:council_id])
    end
    
    respond_to do |format|
      flash[:success] = 'Schicht was successfully updated.'
      format.html { redirect_to section_path(@shift.section_id) }
    end
  end
  
  def insert
    @shift = Shift.find(params[:id])
    @shift.update(:person_id => params[:person_id])
    respond_to do |format|
      flash[:success] = 'Schicht was successfully updated.'
      if params[:from_person]
        format.html { redirect_to person_path(params[:person_id]) }
      else
        format.html { redirect_to section_path(@shift.section_id) }
      end
    end
  end
  
  def remove
    @shift = Shift.find(params[:id])
    @shift.update(:person_id => nil )
    respond_to do |format|
      if params[:from_person]
        format.html { redirect_to person_path(params[:person_id]) }
      else
        format.html { redirect_to section_path(@shift.section_id) }
      end
    end
  end
  
  def sortToCouncil
    if request.post?
      puts "START"
      @sections = Section.where("sections.party_id = ?",getActiveParty().id)
      data = {}
      @sections.each do |s|
        shifts = Shift.select("min(id) as id , start,ende, count(start) as count").where("section_id=#{s.id} AND council_id IS NULL").group([:start,:ende])
        if not shifts.empty?
          data[s.id] = shifts
        end
      end
      
      puts "DEBUG"
      
      puts "counc"
      @councils = Council.all
      puts"councs end"
      
      data.each do  |k,shifti|
        shifti.each do |ss|
          #alle schichten dieses bereiches mit diesen Zeiten und ohne Fachschaft
          niceShifts = Shift.where("section_id=#{k} AND council_id IS NULL AND start = ? AND ende = ?",ss.start,ss.ende)
          i = 0
          @councils.each do |c|
            #now look how many sections of these times should go to that council
            lookId = ss.id.to_s + "sliderOutput" + c.id.to_s
            for j in 1..params[lookId.to_sym].to_i
              niceShifts[i].update(:council_id => c.id)
              i += 1
            end
          end
        end
      end
      
      
      respond_to do |format|
        flash[:success] = 'Schichten zugeordnet'
        format.html { redirect_to root_path }
      end
    else
      @sections = Section.where("sections.party_id = ?",getActiveParty().id).order('name ASC')
      @councils = Council.all.order("name ASC")
      
      @oriData = {}
      
      @sections.each do |s|
        shifts = Shift.select("min(id) as id , start,ende, count(start) as count").where("section_id=#{s.id} AND council_id IS NULL").group([:start,:ende]).order("start ASC")
        if not shifts.empty?
          @oriData[s.name] = shifts
        end
      end
    end
    
    #@shifts=Shift.select("min(id) as id , start,ende, count(start) as count").where("section_id=#{s.id} AND council_id IS NULL").group([:start,:ende])
    
  end
  
  def destroy
    @section=Section.find(params[:section_id])
    
    Shift.find(params[:id]).destroy
    
    respond_to do |format|
      format.html{redirect_to(section_path(@section))}
    end
  end
  
  private
  def shift_params
    params.require(:shift).permit(:start, :ende, :person_id, :section_id, :council_id)
  end
end
