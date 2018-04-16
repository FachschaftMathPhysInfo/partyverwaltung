class EmailsController < ApplicationController
  def index
    @mails = Email.all.order('name ASC')
  end
  
  def create
   @mail = Email.new(email_params)

    respond_to do |format|
      if @mail.save
        flash[:success] = 'Mail was successfully created.'
        format.html { redirect_to(@mail) }
      else
        flash[:alert] = 'Could not create mail' 
        format.html { redirect_to(email_path)}
      end
    end  
  end
  
  def update
    @mail = Email.find(params[:id])
   
    respond_to do |format|
      if @mail.update_attributes(email_params)
          flash[:success] = 'Mail was successfully updated.'
          format.html  { redirect_to(@mail)}
      else
          flash[:alert] = 'Could not update Mail'
          format.html { redirect_to(@mail)}
      end
    end
  end
  
  def show
    @mail = Email.find(params[:id])
  end
  
  def destroy
  
  end
  
  def send_all
    @mail = Email.find(params[:id])
    @party = getActiveParty()
    puts(@mail,@party)
    secs = Section.where("party_id = ?",@party.id).order('name ASC')
    secs.each do |s|
      shifts = Shift.where("section_id = ? AND person_id IS NOT NULL",s.id)
      shifts.each do |ss|
        pers = Person.where("id = ?",ss.person_id)
        if pers.size > 0
          pers = pers.first
          puts(pers.name())
        end
      end
    end    
    
    respond_to do |format|
      flash[:success] = 'Mail was successfully sent.'
      format.html { redirect_to(@mail) }
    end
  end
  
  private
  def email_params
    params.require(:email).permit(:name, :subject, :content, :sendcode)
  end
end
