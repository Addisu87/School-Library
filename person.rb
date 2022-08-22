class Person 
  def initialize(id, age, name = 'Unknown', parent_permission: true)
    @id = id
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  attr_reader :id
  attr_accessor :name, :age

  # public method
  def can_use_services?
    of_age? || @parent_permission
  end

  # private method
  private

  def is_of_age?
    @age >= 18
  end
end