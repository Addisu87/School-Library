class CreatePerson
  def create_person
    puts 'Do you want to create
    Student -> [1]
    Teacher -> [2]
    [Input a number]: '
    
    options = gets.chomp

    case options
    when '1'
      create_student
    when '2'
      create_teacher
    end
    print 'Person created successfully!'
    gets
  end

  def inputs_student
    puts 'Create a new student'
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp.capitalize
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp.downcase
    [age, name, permission]
  end

  def create_student
    age, name, permission = inputs_student
    case permission
    when 'n'
      student = Student.new(age, name, permission: false)
      puts 'Student doesnt have parent permission, cant rent books'
    when 'y'
      student = Student.new(age, name, permission: true)
      puts 'Student created successfully'
    end
    student
  end

  def inputs_teacher
    puts 'Create a new teacher'
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp.capitalize
    print 'Specialization: '
    specialization = gets.chomp
    [age, name, specialization]
  end

  def create_teacher
    age, name, specialization = inputs_teacher
    teacher = Teacher.new(age, name, nil, specialization)
    puts 'Teacher created successfully'
    teacher
  end
end
