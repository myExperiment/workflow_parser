require 'minitest/autorun'
require 'workflow_parser/workflow_processor'
require 'stringio'

module Example
  class Fred < WorkflowParser::WorkflowProcessor
    def self.mime_type
      "application/x-fred"
    end
    def self.file_extensions_supported
      ["fred"]
    end
    def self.recognized?(file)
      file.read(10).start_with? ">> fred"
    end
  end
  class Soup < Fred
    def self.mime_type
      "application/x-soup"
    end
    def self.file_extensions_supported
      ["other", "soup", "more"]
    end
    def self.recognized?(file)
      file.read() == "soup-file"
    end
  end
end

class WorkflowProcessorTest < MiniTest::Test
  def test_implementations
    impls = WorkflowParser::WorkflowProcessor.implementations
    assert impls.include? Example::Fred
    assert impls.include? Example::Soup
  end

  def test_for
     assert_equal Example::Fred,
       WorkflowParser::WorkflowProcessor.for  # matches first one
     assert_equal Example::Fred,
       WorkflowParser::WorkflowProcessor.for(:mime_type => "application/x-fred")
     assert_equal Example::Fred,
       WorkflowParser::WorkflowProcessor.for(:default_file_extension => "fred")
     assert_equal Example::Fred,
       WorkflowParser::WorkflowProcessor.for(:mime_type => "application/x-fred",
                                             :default_file_extension => "fred")
     assert_equal Example::Fred,
       WorkflowParser::WorkflowProcessor.for(:file_extensions_supported => ["fred"])
     assert_equal Example::Fred,
       WorkflowParser::WorkflowProcessor.for(:mime_type => "application/x-fred",
                                             :default_file_extension => "fred")
     assert_nil WorkflowParser::WorkflowProcessor.for(:mime_type => "application/x-fred",
                                                      :default_file_extension => "unknown")
     assert_equal Example::Soup,
       WorkflowParser::WorkflowProcessor.for(:mime_type => "application/x-soup")
     assert_equal Example::Soup,
         WorkflowParser::WorkflowProcessor.for([:file_extensions_supported] => "soup")
     assert_nil WorkflowParser::WorkflowProcessor.for(:mime_type => "application/x-unknown")
  end

  def test_for_file
    file = StringIO.new(">> fred file")
    p = WorkflowParser::WorkflowProcessor.for_file(file)
    assert p.is_a?(Example::Fred)
  end

  def test_for_file_without_instantiate
    file = StringIO.new("soup-file")
    # Should be the class instead of instance
    assert_equal Example::Soup,
      WorkflowParser::WorkflowProcessor.for_file(file, false)
  end



end
