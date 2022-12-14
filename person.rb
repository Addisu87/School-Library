require_relative 'nameable'

class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age, :parent_permission, :rentals

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000).to_s
    @age = age
    @name = name
    @parent_permission = parent_permission
    @rentals = []
  end

  def correct_name
    @name
  end

  # public method
  def can_use_services?
    of_age? || @parent_permission
  end

  def add_rental(date, book)
    Rental.new(date, book, self)
  end

  # private method
  private

  def of_age?
    @age >= 18
  end
end
