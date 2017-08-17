class Party < ApplicationRecord
  #has_many :sections, :dependent => :destroy
  has_many :notes, :dependent => :nullify
  
  def name
    return jahr.to_s + "," + semester.to_s
  end
end
