require_relative "processor"

describe "Processor" do
  context "#process" do
    it "parses a line of text" do
      response = Processor.process("$4.99 TXT MESSAGING – 250 09/29 – 10/28 4.99", 1)
      response.should == "{\n" +
                         "  “feature” : “TXT MESSAGING – 250”,\n" +
                         "  “date_range” : “09/29 – 10/28”,\n" +
                         "  “price” : 4.99\n" +
                         "}\n"
    end

    it "returns an error message for an improperly formatted line of text" do
      response = Processor.process("NOT PROPERLY FORMATTED", 2)
      response.should == "{\n" +
                         "  “error” : “The text on line 2 is improperly formatted.”\n" +
                         "}\n"
    end

    it "accepts prices without dollars" do
      response = Processor.process("$4.99 TXT MESSAGING – 250 09/29 – 10/28 .99", 3)
      response.should == "{\n" +
                         "  “feature” : “TXT MESSAGING – 250”,\n" +
                         "  “date_range” : “09/29 – 10/28”,\n" +
                         "  “price” : .99\n" +
                         "}\n"
    end
  end

  context "#process_file" do
    it "processes a single-line file" do
      response = Processor.process_file("test_files/single_line_test.txt")
      response.should == "{\n" +
                         "  “feature” : “TXT MESSAGING – 250”,\n" +
                         "  “date_range” : “09/29 – 10/28”,\n" +
                         "  “price” : 4.99\n" +
                         "}\n"
    end

    it "processes a multi-line file" do
      response = Processor.process_file("test_files/multi_line_test.txt")
      response.should == "{\n" +
                         "  “feature” : “TXT MESSAGING – 250”,\n" +
                         "  “date_range” : “09/29 – 10/28”,\n" +
                         "  “price” : 4.99\n" +
                         "}\n" +
                         "{\n" +
                         "  “feature” : “DATA – 2GB”,\n" +
                         "  “date_range” : “09/29 – 10/28”,\n" +
                         "  “price” : 24.99\n" +
                         "}\n"
    end

    it "indicates when a line is formatted improperly" do
      response = Processor.process_file("test_files/bad_format.txt")
      response.should == "{\n" +
                         "  “error” : “The text on line 1 is improperly formatted.”\n" +
                         "}\n"
    end
  end
end

