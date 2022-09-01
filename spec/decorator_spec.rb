require_relative '../capitalize_decorator'
require_relative '../person'
describe CapitalizeDecorator do
    it 'should return the first charactere of the name in UpperCase' do

            person = Person.new(24, 'yankee')
            person.correct_name.capitalize
            capitalizer = CapitalizeDecorator.new(person)
  
                   
            expect(capitalizer.correct_name).to eq 'Yankee'
            end

end