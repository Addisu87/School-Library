require 'json'

class PreserveFile
  def save_to_json(data, file)
    file = File.open(file, 'w')
    file.write(JSON.generate(data))
    file.close
    'success'
  end

  def read_json(file)
    return [] unless File.exist?(file)

    file = File.open(file, 'r')
    file_data = JSON.parse(file.read)
    file.close
    file_data
  rescue StandardError
    puts "No file found to read on #{file}"
    nil
  end
end
