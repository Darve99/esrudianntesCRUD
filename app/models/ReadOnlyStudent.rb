class ReadOnlyStudent < ApplicationRecord
    self.abstract_class = true
    establish_connection :reading
  
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :age, numericality: { only_integer: true, greater_than: 0 }
  end