class PeopleController < ApplicationController
  def index
    #@people=Person.all.order("vname ASC")
    @people = Person.joins(:status).select("people.*, statuses.value as stat").order("vname ASC")
  end

  def create
    @person = Person.new(person_params)
    @person.vname=@person.vname.titleize
    @person.nname=@person.nname.titleize
    @person.wert=0

    respond_to do |format|
      if @person.save
        s = Status.new(:person_id => @person.id, :value => 0)
        s.save!
        
        flash[:success] = 'Person was successfully created.'
        format.html { redirect_to(@person) }
      else
        flash[:alert] = 'Could not create person' 
        format.html { redirect_to(people_path)}
      end
    end
  end
  
  def update
    @person = Person.find(params[:id])
    #TODO
    #@person.wert=person_wertung(params[:id])
    
    respond_to do |format|
      if @person.update_attributes(person_params)
          flash[:success] = 'person was successfully updated.'
          format.html  { redirect_to(@person)}
      else
          flash[:alert] = 'Could not update person'
          format.html { redirect_to(@person)}
      end
    end
  end

  def show
    @person = Person.find(params[:id])
    @notes = @person.notes.order('created_at DESC')
    @bls = Section.joins(:section_managers).select("sections.*").order("name ASC")
  end
  
  def change_status
    person = Person.find(params[:id])
    status = person.status.first
    case params[:type].to_i
    when 1
      if status.value == 1
        status.update(:value => 0)
      else
        status.update(:value => 1)
      end
    when -1
      if status.value == -1
        status.update(:value => 0)
      else
        status.update(:value => -1)
      end
    end
    redirect_to person
  end
  
  def destroy
    @person = Person.find(params[:id])
    @person.destroy
       
    respond_to do |format|
      format.html { redirect_to(people_path) }
    end
  end
  
  private
  def person_params
    params.require(:person).permit(:vname, :nname, :mail, :shirt, :typ)
  end
end
