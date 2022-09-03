class CreateRental
  def inputs_book
    puts 'Select which book you want to rent by entering its number'
    books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }
    gets.chomp.to_i
  end

  def inputs_person
    puts 'Select a person from the list by its number'
    people.each_with_index do |p, index|
      puts "#{index}) [#{p.class.name}] Name: #{p.name}, ID: #{p.id}, Age: #{p.age}"
    end
    gets.chomp.to_i
  end

  def inputs
    book_id = inputs_book
    person_id = inputs_person
    print 'Date: '
    date = gets.chomp.to_s
    [book_id, person_id, date]
  end

  def create_rental
    book_id, person_id, date = inputs
    rental = Rental.new(date, people[person_id], books[book_id])
    puts 'Rental created successfully'
    rental
  end
end
