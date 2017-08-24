class Shift < ApplicationRecord
  belongs_to :council, optional: true
  belongs_to :section
  belongs_to :person, optional: true
  
  validates_presence_of :start
  validates_presence_of :ende
end
