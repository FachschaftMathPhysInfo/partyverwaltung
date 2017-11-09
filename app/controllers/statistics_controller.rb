class StatisticsController < ApplicationController
  def index
    @parties = Party.all.order('jahr ASC, semester ASC')
    @helper = Person.select("DISTINCT people.*")
                  .from("( people INNER JOIN shifts ON people.id = shifts.person_id ) INNER JOIN sections ON sections.id = shifts.section_id")
                  .where("sections.party_id IN (?)",@parties.ids)
    @helperPerParty = {}
    @parties.each do |p|
      men = Person.select("DISTINCT people.*")
                  .from("( people INNER JOIN shifts ON people.id = shifts.person_id ) INNER JOIN sections ON sections.id = shifts.section_id")
                  .where("sections.party_id IN ?",p.id)
      @helperPerParty[p.name] = men
    end
    
  end
  
  def shirts
    if request.post?
      if params.has_key?(:all)
        @parties = Party.all.order('jahr ASC, semester ASC')
      else
        ids = params[:data].keys.map{|x| x.to_i }
        @parties = Party.where("id IN (?)",ids).order('jahr ASC, semester ASC')
      end
      @helper = Person.select("DISTINCT people.*")
                  .from("( people INNER JOIN shifts ON people.id = shifts.person_id ) INNER JOIN sections ON sections.id = shifts.section_id")
                  .where("sections.party_id IN (?)",@parties.ids)
                  
      @hpp = {} #helper per party
      @parties.each do |p|
        @hpp[p.id] = Person.select("DISTINCT people.*")
                  .from("( people INNER JOIN shifts ON people.id = shifts.person_id ) INNER JOIN sections ON sections.id = shifts.section_id")
                  .where("sections.party_id = ?",p.id)
      end
    end
  end
  
  def helper
    if request.post?
      @h = Person.find(params[:h_id])
      @where = Shift.joins(:section).select("COUNT(sections.name) AS count, sections.name AS name").where("shifts.person_id = ?", @h.id).group("sections.name")
      @bl = SectionManager.joins(:section).select("COUNT(sections.name) AS count, sections.name AS name").where("section_managers.person_id = ?",@h.id).group("sections.name")
    end
  end
  
  def section
    if request.post?
      @p = Party.all.order('jahr ASC, semester ASC')
      @name = params[:b_name]
      @secs = Section.joins(:party).select("sections.id as id, sections.name as name, parties.id as pid").where("sections.name = ?", params[:b_name])
      @shifts = Shift.joins(:section).where("shifts.section_id IN (?)", @secs.ids)
    end
  end
end
