require 'minitest/autorun'
require 'workflowparser/workflowprocessor'

module Example
  class Fred < WorkflowParser::WorkflowProcessor
    def self.mime_type
      "application/x-fred"
    end
    def self.default_file_extension
      "fred"
    end
  end
  class Soup < WorkflowParser::WorkflowProcessor
    def self.mime_type
      "application/x-soup"
    end
  end
end

class WorkflowProcessorTest < MiniTest::Test
  def test_for
     assert_equal Example::Fred,
       WorkflowParser::WorkflowProcessor.for
     assert_equal Example::Fred,
       WorkflowParser::WorkflowProcessor.for(:mime_type => "application/x-fred")
     assert_equal Example::Fred,
       WorkflowParser::WorkflowProcessor.for(:default_file_extension => "fred")
     assert_equal Example::Fred,
       WorkflowParser::WorkflowProcessor.for(:mime_type => "application/x-fred",
                                             :default_file_extension => "fred")
     assert_equal Example::Fred,
       WorkflowParser::WorkflowProcessor.for(:mime_type => "application/x-fred",
                                             :default_file_extension => "fred")
     assert_nil WorkflowParser::WorkflowProcessor.for(:mime_type => "application/x-fred",
                                                      :default_file_extension => "unknown")
     assert_equal Example::Soup,
       WorkflowParser::WorkflowProcessor.for(:mime_type => "application/x-soup")
     assert_nil WorkflowParser::WorkflowProcessor.for(:mime_type => "application/x-unknown")
  end

end
