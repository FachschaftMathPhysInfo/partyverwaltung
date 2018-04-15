class EmailsController < ApplicationController
  def index
    @mails = Email.all.order('name ASC')
  end
  
  def reminder
  
  end
end
