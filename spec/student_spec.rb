require_relative '../student'

describe 'Student' do
  before(:each) do
    @student = Student.new(24, 'Menanya Morris', 'true')
  end

  it 'Take age, name and parent_permission' do
    expect(@student.age).to eq 24
    expect(@student.name).to eq 'Menanya Morris'
    expect(@student.parent_permission).to eq 'true'
  end

  it 'should return "¯\(ツ)/¯" when calling play_hooky' do
    expect(@student.play_hooky).to eq '¯\(ツ)/¯'
  end

  it 'Has return classroom of student when adding the classroom ' do
    classroom = Classroom.new('Physics')
    @student.classroom = classroom
    expect(@student.classroom).to eq classroom
  end
end
