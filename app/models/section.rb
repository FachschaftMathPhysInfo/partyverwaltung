class Section < ApplicationRecord
  belongs_to :party
  has_many :section_managers, :dependent => :destroy
  #has_many :shifts, :dependent => :destroy
end
