# app/models/student.rb
class Student < ApplicationRecord
  establish_connection :writing

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :age, numericality: { only_integer: true, greater_than: 0 }
end


