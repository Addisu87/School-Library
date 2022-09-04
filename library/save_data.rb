require_relative '../student'
require_relative '../teacher'
require_relative '../rental'

def save_data
  add_book_data
  add_people_data
  add_rent_data
end

def add_book_data
  book_collection = []
  @books.map do |book|
    book_collection << { title: book.title, author: book.author, id: book.id }
  end

  ruby = JSON.pretty_generate(book_collection)
  File.write('../data/books.json', ruby.to_S)
end

def add_people_data
  people_collection = []
  @persons.map do |person|
    if person.instance_of?(Student)
      { type: 'student', id: person.id, age: person.age, name: person.name,
        parent_permission: person.parent_permission }
    else
      { type: 'teacher', id: person.id, age: person.age, name: person.name, specialization: person.specialization }
    end
  end

  ruby = JSON.pretty_generate(people_collection)
  File.write('../data/person.json', ruby.to_S)
end

def add_rent_data
  rental_collection = @rentals.map do |r|
    { date: r.date, person_id: r.person.id, name: r.person.name, book_title: r.book.title, book_id: r.book.id }
  end

  ruby = JSON.pretty_generate(rental_collection)
  File.write('../data/rentals.json', ruby.to_S)
end
