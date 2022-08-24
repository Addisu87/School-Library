require_relative './person'
require_relative './book'
require_relative './student'
require_relative './teacher'
require_relative './rental'

class App
  attr_reader :people, :books, :rentals

  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def menu
    puts 'Welcome to School library App!\n\n'
    puts 'Please choose an option by enter in a number: '
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit\n\n'
    gets.chomp
  end

  def run
    options = menu
    case options
    when '1'
      list_all_books
    when '2'
      list_all_people
    when '3'
      create_person
    when '4'
      create_book
    when '5'
      create_rental
    when '6'
      list_all_rentals
    else
      puts 'Thank you for using this app!'
      exit
    end
  end

  def list_all_books
    if @books.size.positive?
      puts 'Here are the books registered at the moment: '
      @books.each_with_index { |book, index| puts "#{index}) Title: \"#{book.title}\" Author: #{book.author}" }
    else
      puts 'There are no books registered at the moment'
    end
    gets.chomp
    run
  end

  def list_all_people
    if @people.size.positive?
      puts 'Here are the people registered at the moment: '
      @people.each_with_index { |p, index| puts "#{index}) [#{p.class}] Name: #{p.name}, ID: #{p.id}, Age: #{p.age}" }
    else
      puts 'There are no people registered at the moment.'
    end
    gets.comp
    run
  end

  def permision_options(my_char)
    case my_char
    when 'N'
      false
    when 'Y'
      true
    end
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp.capitalize
    print 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(age, name, nil, specialization)
    @people.push(teacher)
  end

  def create_student
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp.capitalize
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp
    student = Student.new(age, name, permission)
    @people.push(student)
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    person_type = gets.chomp
    case person_type
    when '1'
      create_student
    when '2'
      create_teacher
    end
    print 'Person created successfully!'
    gets
    run
  end

  def create_book
    puts 'Title:\t'
    title = gets.chomp.capitalize
    puts 'Author:\t'
    author = gets.chomp.capitalize
    new_book = Book.new(title, author)
    @books.push(new_book)
    puts 'Book created successfully!'
    run
  end

  def create_rental
    puts '\nSelect a book from the following list by number'
    list_all_books
    book_idx = gets.chomp.to_i
    puts '\nSelect a person from the following list by number'
    list_all_people
    person_idx = gets.chomp.to_i
    print '\n Date(yyyy/mm/dd): '
    rental_date = gets.chomp
    new_rental = Rental.new(rental_date, @books[book_idx.to_i], @people[person_idx.to_i])
    @rentals.push(new_rental)
    puts 'Rental added successfully!'
    run
  end

  def list_all_rentals(person_id)
    rentals = @rentals[person_id] || []
    puts 'Rentals: '
    puts 'No rentals under this ID' if rentals.empty?
    rentals.each do |r|
      puts "Date: #{r.date}, Book: \"#{r.book.title}\" by #{r.book.author}, Rented by: #{r.person.name}"
    end
    run
  end
end
