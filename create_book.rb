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
    @books.push(new_book)
    puts "Book #{title} created successfully!"
    run
  end
end
