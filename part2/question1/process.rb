require_relative("processor")
require("fileutils")

input = ARGV[0]
output = ARGV[1]

if input.nil?
  puts "Please include the filename of the file you wish to process."
else
  result = Processor.process_file(input)
  if output.nil?
    puts result
  else
    dir = File.dirname(output)

    unless File.directory?(dir)
      FileUtils.mkdir_p(dir)
    end

    File.open(output, File::WRONLY|File::CREAT) do |file|
      file.write(result)
    end
  end
end