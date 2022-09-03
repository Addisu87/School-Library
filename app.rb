require_relative './person'
require_relative './book'
require_relative './student'
require_relative './teacher'
require_relative './rental'
require_relative './library/create_person'
require_relative './library/create_book'
require_relative './library/create_rental'
require_relative './library/list_all_rental'
require_relative './library/load_data'
require 'json'

class App
  attr_reader :people, :books, :rentals

  def initialize
    @people = load_people
    @books = load_books
    @rentals = load_rentals
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

  def create_person
    @people << CreatePerson.new.create_person
    run
  end

  def create_book
    @books << CreateBook.new.create_book
    run
  end

  def create_rental
    @rentals << CreateRental.new.create_rental
    run
  end

  def list_all_rentals
    @rentals << ListAllRental.new.list_all_rentals
    run
  end
end
