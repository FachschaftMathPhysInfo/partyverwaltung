class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include ApplicationHelper
  
  before_action do @userData = user_data end
  before_action do @party_active = getActiveParty end
  before_action do access? end
end
