class Person < ApplicationRecord
  has_many :section_managers, :dependent => :destroy
  #has_many :shifts, :dependent => :nullify
  has_many :notes, :dependent => :destroy
  has_many :status, :dependent => :destroy
      
  validates :vname, presence: true
  validates :nname, presence: true
  validates :mail, :format => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

  def name
    return vname.to_s+" "+nname.to_s
  end
end
