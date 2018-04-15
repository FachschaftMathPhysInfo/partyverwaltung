class JudgesController < ApplicationController  
  def index
    Rails.application.eager_load!
    @links = {}
    controllers = ApplicationController.descendants.sort!{|x,y| x.to_s <=> y.to_s}
    controllers.each do |a|
      methods = a.instance_methods(false).to_a.sort!
      @links[a] =[]
      methods.each do |m|
        entry = Judge.where("controller = :con AND method = :met",{con: a.to_s, met: m}).first
        if entry
          @links[a].push(entry)
        end
      end
    end
    
  end
  
  def init
    #load new...THIS IS ONLY CALLED BY THE RAKE TASK
    Rails.application.eager_load!
    controllers = ApplicationController.descendants
    
    controllers.each do |c|
      c.instance_methods(false).to_a.each do |a|
        #check if entry exists and add if not
        e = Judge.where("controller = :con AND method = :met",{con: c.to_s, met: a})
        if e.empty?
          j = Judge.new(:controller => c.to_s, :method => a, :level => 0)
          j.save
        end
      end
    end
    redirect_to judges_index_path
  end
  
  def change
    Judge.find(params[:e]).update(:level => params[:v])
    redirect_to judges_index_path
  end
  
  def change_controller
    all = Judge.where("controller = :con",{con: params[:e]})
    all.each do |a|
      a.update(:level => params[:v])
    end
    redirect_to judges_index_path
  end
end
