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
      shifts = Shift.where("section_id = ? AND council_id = ?", s.id, council.id).order("start-interval '8 hours' ASC")#.order('start DESC')
      unless shifts.empty?
        @data[s.name] = []
        shifts.each do |ss|
          @data[s.name] << [ ss.start.to_s(:time), ss.ende.to_s(:time) ]
        end
      end
    end
    
    @orient = "landscape"

    respond_to do |format|
      format.pdf {render 'empty_list'}
      format.html {redirect_to (origins_lists_path)}
    end  
  end
  
  def list_filled
    council = Council.where("name = ?", params[:counc]).first
    
    sections=Section.where("party_id = ? AND visible=true", getActiveParty().id).order('name')
    
    @data = {}
    
    sections.each do |s|
      #shifts = Shift.where("section_id = ? AND council_id = ?", s.id, council.id).order("start-interval '8 hours' ASC")#.order('start DESC, person_id')
      shifttimes = Shift.select("start,ende").where("section_id = ? AND council_id = ?", s.id, council.id).order("start-interval '8 hours' ASC").group("start,ende")
      unless shifttimes.empty?
        @data[s.name] = []
        shifttimes.each do |t|
          shifts = Shift.where("section_id = ? AND council_id = ? AND start = ? AND ende = ?", s.id, council.id, t.start, t.ende).order("person_id ASC NULLS LAST")
          shifts.each do |ss|
            input = [ ss.start.to_s(:time), ss.ende.to_s(:time) ]
            if ss.person_id
              perso = Person.find(ss.person_id)
              input << perso.vname
              input << perso.nname
              input << perso.shirt
              input << "(" + perso.typ.to_s[0] + ")"
            else
              input << ""
              input << ""
              input << ""
              input << ""
            end
            @data[s.name] << input
          end
        end
      end
    end
    
    @orient = "landscape"

    respond_to do |format|
      format.pdf {render 'filled_list'}
      format.html {redirect_to (origins_lists_path)}
    end  
  end
  
  def list_needy
    council = Council.where("name = ?", params[:counc]).first
    
    sections = Section.where("party_id = ? AND visible=true", getActiveParty().id).order('name')
    
    @data = {}
    
    sections.each do |s|
      ## check if empty shifts exist
      shifts = Shift.where("section_id = ? AND council_id = ?", s.id, council.id).order("start-interval '8 hours' ASC")#.order('start DESC, person_id')
      checkShift = shifts.select{|x| x.person_id == nil}
      unless checkShift.empty?
        #shifts = Shift.where("section_id = ? AND council_id = ?", s.id, council.id).order("start-interval '8 hours' ASC")#.order('start DESC, person_id')
        shifttimes = Shift.select("start,ende").where("section_id = ? AND council_id = ?", s.id, council.id).order("start-interval '8 hours' ASC").group("start,ende")
        unless shifttimes.empty?
          @data[s.name] = []
          shifttimes.each do |t|
            shifts = Shift.where("section_id = ? AND council_id = ? AND start = ? AND ende = ?", s.id, council.id, t.start, t.ende).order("person_id ASC NULLS LAST")
            shifts.each do |ss|
              input = [ ss.start.to_s(:time), ss.ende.to_s(:time) ]
              if ss.person_id
                perso = Person.find(ss.person_id)
                input << perso.vname
                input << perso.nname
                input << perso.shirt
                input << "(" + perso.typ.to_s[0] + ")"
              else
                input << ""
                input << ""
                input << ""
                input << ""
              end

              @data[s.name] << input
            end
          end
        end
      end
    end
    
    @orient = "landscape"

    respond_to do |format|
      format.pdf {render 'filled_list'}
      format.html {redirect_to (origins_lists_path)}
    end  
  end

  def list_needy_clear
    council = Council.where("name = ?", params[:counc]).first
    
    sections=Section.where("party_id = ? AND visible=true", getActiveParty().id).order('name')
    
    @data = {}
    
    sections.each do |s|
      shifts = Shift.where("section_id = ? AND council_id = ? AND person_id IS NULL", s.id, council.id).order("start-interval '8 hours' ASC")#.order('start DESC')
      unless shifts.empty?
        @data[s.name] = []
        shifts.each do |ss|
          @data[s.name] << [ ss.start.to_s(:time), ss.ende.to_s(:time) ]
        end
      end
    end
    
    @orient = "landscape"

    respond_to do |format|
      format.pdf {render 'empty_list'}
      format.html {redirect_to (origins_lists_path)}
    end  
  end
  
  def list_section
    sections=Section.where("party_id = ?", getActiveParty().id).order('name')
    
    @data = {}
    
    sections.each do |s|
      shifts = Shift.joins(:person).select("people.vname as name").where("section_id = ?", s.id).order("vname,nname ASC")
      unless shifts.empty?
        @data[s.name] = []
        shifts.each do |ss|
          @data[s.name] << ss.name
        end
      end
    end
    
    @orient = "portrait"
    
    respond_to do |format|
      format.pdf {render 'section_list'}
      format.html {redirect_to (origins_lists_path)}
    end
  end
  
  def list_shirt
    sections=Section.where("party_id = ?", getActiveParty().id).order('name')
    
    @data = {}
    
    sections.each do |s|
      shifts = Shift.joins(:person).select("people.vname as vname, people.nname as nname,people.shirt as shirt, people.typ as typ").where("section_id = ?", s.id).order("vname,nname ASC")
      unless shifts.empty?
        @data[s.name] = []
        shifts.each do |ss|
          @data[s.name] << [ss.vname.to_s+" "+ss.nname.to_s, ss.shirt.to_s+" ("+ss.typ.to_s+")"]
        end
        @data[s.name].uniq!
      end
    end
    
    @orient = "portrait"
    
    respond_to do |format|
      format.pdf {render 'shirt_list'}
      format.html {redirect_to (origins_lists_path)}
    end
  end
  
  def list_veteran
    @vets = Person.joins(:status).select("people.*").where("statuses.value = 1").order("vname,nname ASC")
    
    @orient = "portrait"
    
    respond_to do |format|
      format.pdf {render 'veteran_list'}
      format.html {redirect_to (origins_lists_path)}
    end
  end
  
  def garderobe_bons
    if params[:bonCount].to_i%200 == 0
      @bons = params[:bonCount].to_i
    else
      @bons = params[:bonCount].to_i + ( 200 - params[:bonCount].to_i%200 )
    end
    
    @chunks = @bons / 200
    
    @text = params[:text].to_s.gsub("\r\n","\\newline ")
    
    @orient = "landscape"
    
    respond_to do |format|
      format.pdf {render 'garderobe_bons', layout:"bons"}
      format.html {redirect_to (origins_lists_path)}
    end
  end
end
