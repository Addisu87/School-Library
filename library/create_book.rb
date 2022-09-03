class CreateBook
  def inputs
    puts 'Title: '
    title = gets.chomp.capitalize
    puts 'Author: '
    author = gets.chomp.capitalize
    [title, author]
  end

  def create_book
    title, author = inputs
    new_book = Book.new(title, author)
    puts "Book #{title} created successfully!"
    new_book
  end
end
