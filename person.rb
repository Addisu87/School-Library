require_relative './nameable'

class Person < Nameable
  attr_reader :id, :rentals
  attr_accessor :name, :age

  def initialize(age, name = 'Unknown', parent_permission: true, id: nil)
    @id = id || Random.rand(1..1000).to_s
    @age = age
    @name = name
    @parent_permission = parent_permission
    @rentals = []
    super()
  end

  def correct_name
    @name
  end

  # public method
  def can_use_services?
    of_age? || @parent_permission
  end

  def add_rental(date, book)
    Rental.new(date, self, book)
  end

  # private method
  private

  def of_age?
    @age >= 18
  end
end
