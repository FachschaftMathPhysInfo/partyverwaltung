class LogsController < ApplicationController
  def index
    @logs = Log.all.order("created_at DESC").limit(100)
    if params.has_key?(:cFilter)
      @logs = @logs.select{ |x| x.controller == params[:cFilter] }
    end
    if params.has_key?(:mFilter)
      @logs = @logs.select{ |x| x.method == params[:mFilter] }
    end
    if params.has_key?(:lUser)
      @logs = @logs.select{ |x| x.user == params[:lUser] }
    end

    Rails.application.eager_load!
    @conts = {}
    @meths = {}
    @methCol = []
    controllers = ApplicationController.descendants.sort!{|x,y| x.to_s <=> y.to_s}
    controllers.each do |a|
      methods = a.instance_methods(false).to_a.sort!
      cut = a.to_s.chomp('Controller')
      @conts[cut] = cut
      methods.each do |m|
        @methCol << m
      end
    end
    @methCol.uniq!
    @methCol.each do |mm|
      @meths[mm] = mm
    end
    
    @lUsers = {}
    userList = Right.all.select("rights.nick")
    userList.each do |u|
      @lUsers[u.nick] = u.nick
    end
  end
end
