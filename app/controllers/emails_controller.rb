class EmailsController < ApplicationController
  def index
    @mails = Email.all.order('name ASC')
  end
  
  def create
  
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
