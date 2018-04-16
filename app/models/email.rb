class Email < ApplicationRecord
  validates :name, presence: true
  validates :subject, presence: true
  validates :sendcode, presence: true
  
  def codes
    return {'eine Person' => 'U', 'einen Bereich' => 'S', 'alle der aktuellen Party' => 'CP'}
  end
  
  def codeToExpl(c)
    turn = codes.invert
    return turn[c]
  end
  
  def ExplToCode(e)
    return codes[e]
  end
  
end
