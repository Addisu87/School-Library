require_relative './person'
require_relative './book'
require_relative './student'
require_relative './teacher'
require_relative './rental'
require_relative 'preserve_file'
require 'json'

class App
  attr_reader :people, :books, :rentals

  def initialize
    @people = []
    @books = []
    @rentals = []
    @store_file = PreserveFile.new
    load_people
    load_books
    load_rentals
  end

  def load_people
    stored_people = @store_file.read_json('data/person.json')
    stored_people.map do |p|
      case p['type']
      when 'student'
        @persons << Student.new(p['age'], p['classroom'], p['name'], p['id'], parent_permission: p['permission'])
      when 'teacher'
        @persons << Teacher.new(p['age'], p['specialization'], p['name'], p['id'])
      end
    end
  end

  def load_books
    stored_books = @store_file.read_json('data/book.json')
    stored_books.map do |book|
      @books.push(Book.new(book['title'], book['author']))
    end
  end

  def load_rentals
    stored_rental = @store_file.read_json('data/rent.json')
    stored_rental.each do |rental|
      person = @persons.find { |p| p.id == rental['person_id'] }
      book = @books.find { |b| b.title == rental['book_title'] }
      @rentals.push(Rental.new(rental['date'], book, person))
    end
  end

  def add_rent_data
    rental_collection = @rentals.map do |r|
      { date: r.date, person_id: r.person.id, name: r.person.name, book_title: r.book.title, book_id: r.book.id }
    end
    @store_file.save_to_json(rental_collection, 'data/rent.json')
  end

  def add_people_data
    people_collection = @persons.map do |person|
      if person.instance_of?(Student)
        { type: 'student', id: person.id, age: person.age, name: person.name,
          parent_permission: person.parent_permission }
      else
        { type: 'teacher', id: person.id, age: person.age, name: person.name, specialization: person.specialization }
      end
    end
    @store_file.save_to_json(people_collection, 'data/person.json')
  end

  def add_book_data
    book_collection = @books.map do |book|
      { title: book.title, author: book.author, id: book.id }
    end
    @store_file.save_to_json(book_collection, 'data/book.json')
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
      @people.each_with_index do |p, index|
        puts "#{index}) [#{p.class.name}] Name: #{p.name}, ID: #{p.id}, Age: #{p.age}"
      end
    else
      puts 'There are no people registered at the moment.'
    end
    gets.chomp
    run
  end

  def perm_options(my_char)
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
    student = Student.new(age, name, perm_options(permission), nil)
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
    book_id = gets.chomp.to_i
    puts '\nSelect a person from the following list by number'
    list_all_people
    person_id = gets.chomp.to_i
    print '\n Date(yyyy/mm/dd): '
    rental_date = gets.chomp.to_s
    new_rental = Rental.new(rental_date, @books[book_id], @people[person_id])
    @rentals.push(new_rental)
    puts 'Rental added successfully!'
    run
  end

  def list_all_rentals
    rentals = @rentals.select { |rental| rental.person.id == person_id }
    puts 'Rentals: '
    puts 'No rentals under this ID' if rentals.empty?
    rentals.each do |r|
      puts "Date: #{r.date}, Book: \"#{r.book.title}\" by #{r.book.author}, Rented by: #{r.person.name}"
    end
    run
  end
end
