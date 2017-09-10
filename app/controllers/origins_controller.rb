class OriginsController < ApplicationController

  def index

  end
  
  def administration
  
  end
  
  def bad_boy
  
  end
  
  def lists
  
  end
  
  def list_empty
    council = Council.where("name = ?", params[:counc]).first
    
    sections=Section.where("party_id = ? AND visible=true", getActiveParty().id).order('name')
    
    @data = {}
    
    sections.each do |s|
      shifts = Shift.where("section_id = ? AND council_id = ?", s.id, council.id).order('start DESC')
      unless shifts.empty?
        @data[s.name] = []
        shifts.each do |ss|
          @data[s.name] << [ ss.start.to_s(:time), ss.ende.to_s(:time) ]
        end
      end
    end

    respond_to do |format|
      format.pdf {render 'empty_list'}
      format.html {redirect_to (origins_lists_path)}
    end  
  end

end
