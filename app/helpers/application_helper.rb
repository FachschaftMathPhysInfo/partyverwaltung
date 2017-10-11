module ApplicationHelper

def http_remote_user
	request.env['REMOTE_USER'] || request.env['HTTP_REMOTE_USER'] || request.headers['X-Forwarded-User'] || "admin"
end

def allEnv
  stuff = ['SERVER_NAME',
'PATH_INFO',
'REMOTE_HOST',
'HTTP_ACCEPT_ENCODING',
'HTTP_USER_AGENT',
'SERVER_PROTOCOL',
'HTTP_CACHE_CONTROL',
'HTTP_ACCEPT_LANGUAGE',
'HTTP_HOST',
'REMOTE_ADDR',
'SERVER_SOFTWARE',
'HTTP_KEEP_ALIVE',
'HTTP_REFERER',
'HTTP_COOKIE',
'HTTP_ACCEPT_CHARSET',
'REQUEST_URI',
'SERVER_PORT',
'GATEWAY_INTERFACE',
'QUERY_STRING',
'REMOTE_USER',
'HTTP_REMOTE_USER',
'X-Forwarded-User',
'HTTP_ACCEPT',
'REQUEST_METHOD',
'HTTP_CONNECTION']
ret = stuff.map{ |x| [x,request.env[x]] }
end

#prepares user data
def user_data
  dataBlock = {}
  #user-level
    uR = Right.where("nick = :rem",{rem: http_remote_user}).first
    if uR
      dataBlock[:uLvl] = uR.level
    else
      dataBlock[:uLvl] = 0
    end
  #method-data
    mJudges = Judge.where("level <= :l",{l: dataBlock[:uLvl]})
    dataBlock[:judges] = mJudges
    
  return dataBlock
end

#decides if user may use function
def canUse(contr,meth)
  data = @userData || user_data
  methods = data[:judges].select{ |x| x.controller == contr and x.method == meth }
  if methods.empty?
    return false
  else
    return true
  end
end

#checks if action may be executed (if url is entered manually e.g.)
def access?
  unless canUse(ActiveSupport::Inflector::camelize(controller_name) + "Controller",action_name) #controller_name.capitalize
    redirect_to bad_boy_path(:con => controller_name, :met => action_name)
  end
  data = @userData || user_data
  #do LOG stuff
  l = Log.new(:controller => controller_name.capitalize, :method => action_name, :user => http_remote_user)
  l.save
end

#gets active party
def getActiveParty
  p = Party.where("active = true").first
end

#calculates person value
def person_wertung(id)
   @notes=Note.where("person_id=#{id}")
   zwischen = 0.0
   counter=0
   @notes.each do |n|
      zwischen += n.wertung
      counter += 1
   end
   if counter != 0
      zwischen /= counter
   end
   zwischen=zwischen.round.to_i
   @person=Person.find(id)
   @person.wert = zwischen
   @person.save
end

end
