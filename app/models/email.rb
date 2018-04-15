class Email < ApplicationRecord
  validates :name, presence: true
  validates :subject, presence: true
  validates :sendcode, presence: true
end
