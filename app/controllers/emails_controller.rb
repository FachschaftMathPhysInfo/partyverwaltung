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
  
  end
  
  def show
    @mail = Email.find(params[:id])
  end
  
  def destroy
  
  end
  
  private
  def email_params
    params.require(:email).permit(:name, :subject, :content, :sendcode)
  end
end
