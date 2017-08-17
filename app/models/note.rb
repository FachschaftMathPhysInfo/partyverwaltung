class Note < ApplicationRecord
  belongs_to :person
  belongs_to :party
  validates_presence_of :wertung
end
