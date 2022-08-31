require_relative '../book'
require_relative '../rental'

describe Book do
  before(:each) do
    @book = Book.new('Dertogada', 'Yesmake Worku')
  end

  it 'Take title and autor' do
    expect(@book.title).to eq 'Dertogada'
    expect(@book.author).to eq 'Yesmake Worku'
    expect(@book.rentals).to eq []
  end

  it 'Take title and author' do
    book2 = Book.new('Fiker Eske Mekaber', 'Hadis Alemayehu')
    expect(book2.title).to eq 'Fiker Eske Mekaber'
    expect(book2.author).to eq 'Hadis Alemayehu'
  end
end
