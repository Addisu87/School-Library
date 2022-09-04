class ListAllRental
  def list_all_rentals
    puts 'To see person rentals enter the person ID: '
    @people.each do |person|
      puts "id: #{person.id}"
    end
    id = gets.chomp.to_i
    puts 'Rented Books: '
    @rentals.each do |rental|
      if rental.person.id == id
        puts "Peson: #{rental.person.name}  Date: #{rental.date}, Book: '#{rental.book.title}' by #{rental.book.author}"
      else
        puts
        puts 'No records where found for the given ID'
      end
    end
  end
end
