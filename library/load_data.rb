require_relative '../student'
require_relative '../teacher'
require_relative '../rental'
require_relative '../preserve_file'

def initialize_files
  File.write('../data/book.json', '[]') unless File.exist?('../data/book.json')
  File.write('../data/person.json', '[]') unless File.exist?('../data/person.json')
  File.write('../data/rent.json', '[]') unless File.exist?('../data/rent.json')
end

def load_people
  persons = []
  stored_people = JSON.parse(File.read('../data/person.json'))
  stored_people.each do |p|
    case p['type']
    when 'student'
      @persons << Student.new(p['age'], p['name'], p['id'], parent_permission: p['permission'])
    when 'teacher'
      @persons << Teacher.new(p['age'], p['specialization'], p['name'], p['id'])
    end
  end
  persons
end

def load_books
  books = []
  stored_books = JSON.parse(File.read('../data/book.json'))
  stored_books.map do |book|
    @books << Book.new(book['title'], book['author'])
  end
  books
end

def load_rentals
  rentals = []
  stored_rental = JSON.parse(File.read('../data/rent.json'))
  stored_rental.each do |rental|
    person = @persons.select { |p| p.id == rental['person_id'] }
    book = @books.select { |b| b.title == rental['book_title'] }
    @rentals << Rental.new(rental['date'], book, person)
  end
  rentals
end
