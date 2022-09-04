require_relative '../student'
require_relative '../teacher'
require_relative '../rental'
require 'pry'

class IOdata
  def initialize(arg)
    @type = arg

    @file = case @type
            when 'books'
              '../data/books.json'
            when 'people'
              '../data/people.json'
            when 'rentals'
              '../data/rentals.json'
            else
              '../data/default.json'
            end
  end

  def read
    file = File.open(@file)
    file_data = file.read
    arr_books = []

    if file_data != ''
      data = JSON.parse(file_data)
      arr_books = make_array(data)
    end

    close(file)
    arr_books
  end

  def write(data)
    file = File.open(@file, 'w')
    File.write(@file, JSON.pretty_generate(make_array(data)))
    close(file)
  end

  def make_array(data)
    arr_items = []

    data.each do |item|
      case @type
      when 'books'
        arr_items << {
          'id' => item['id'], 'title' => item['title'], 'author' => item['author']
        }
      when 'people'
        arr_items << {
          'id' => item['id'], 'name' => item['name'], 'age' => item['age'], 'type' => item['type']
        }
      when 'rentals'
        arr_items << {
          'id' => item['id'], 'book' => item['book'], 'person' => item['person'], 'date' => item['date']
        }
      end
    end

    arr_items
  end

  def close(file)
    file.close
  end
end
