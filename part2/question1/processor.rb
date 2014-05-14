class Processor




  def self.process(string, line_number)
    match = /(?:\$?\d*\.\d\d)\s+(?<feature>.*)\s+(?<date_range>\d\d\/\d\d – \d\d\/\d\d)\s*(?<price>\$?\d*\.\d\d)\s*$/.match(string)
    if match.nil?
      "{\n" +
      "  “error” : “The text on line #{line_number} is improperly formatted.”\n" +
      "}\n"
    else
      "{\n" +
      "  “feature” : “#{match[:feature]}”,\n" +
      "  “date_range” : “#{match[:date_range]}”,\n" +
      "  “price” : #{match[:price]}\n" +
      "}\n"
    end
  end

  def self.process_file(filename)
    result = ""
    File.open(filename) do |file|
      file.each do |line|
        result += process(line, file.lineno)
      end
    end
    result
  end
end