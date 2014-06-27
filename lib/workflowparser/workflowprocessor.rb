# Copyright (c) 2008-2014 University of Manchester and the University of Southampton.

require 'xml/libxml'

module WorkflowParser
  class WorkflowProcessor
    # Begin Class Methods

    $subclasses = []

    def self.inherited(subclass)
      super subclass
      $subclasses << subclass
    end

    def self.implementations
      $subclasses
    end

    # Find first WorkflowProcessor implementation subclass where
    # all the key/value pairs in the filter
    # match the result of calling the corresponding
    # class functions.
    #
    # If the key is a symbol or string, then the
    # matching is done by calling the class function
    # with that name and comparing the result with ==.
    #
    # If the key is a list containing a string or
    # a symbol, then matching is instead done with .include?
    # on the returned collection.
    #
    # Example:
    #
    #     class Fred << WorkflowProcessor
    #         def self.mime_type
    #            "fred"
    #         end
    #     end
    #     WorkflowProcessor.for(:mime_type => "fred")
    #
    # will return Fred
    def self.for(filter={})
      implementations.select { |cl|
        filter.all? do |key,expected|
          if key.respond_to? :first 
            value = cl.send(key.first)
            value.respond_to?(:include?) && value.include?(expected)
          else
            expected == cl.send(key)
          end
        end
      }.first
    end

    # These:
    # - provide information about the Workflow Type supported by this processor,
    # - provide information about the processor's capabilites, and
    # - provide any general functionality.

    # MUST be unique across all processors
    def self.display_name
      ""
    end

    def self.display_data_format
      ""
    end

    def self.mime_type
      "application/octet-stream"
    end

    # All the file extensions supported by this workflow processor.
    # Must be all in lowercase.
    def self.file_extensions_supported
      if self.default_file_extension.nil?
        []
      else
        [self.default_file_extension]
      end
    end

    def self.default_file_extension
      nil
    end

    def self.can_determine_type_from_file?
      false
    end

    def self.recognised?(file)
      false
    end

    def self.can_infer_metadata?
      false
    end

    def self.can_infer_title?
      false
    end

    def self.can_infer_description?
      false
    end

    def self.can_generate_preview_image?
      false
    end

    def self.can_generate_preview_svg?
      false
    end

    def self.show_download_section?
      true
    end

    # End Class Methods


    # Begin Object Initializer

    def initialize(workflow_definition)
      @workflow_definition = workflow_definition
    end

    # End Object Initializer


    # Begin Instance Methods

    # These provide more specific functionality for a given workflow definition, such as parsing for metadata and image generation.

    def get_title
      nil
    end

    def get_description
      nil
    end

    def get_preview_image
      nil
    end

    def get_preview_svg
      nil
    end

    def get_workflow_model_object
      nil
    end

    def get_workflow_model_input_ports

    end

    def get_search_terms
      ""
    end

    def get_components
      XML::Node.new("components")
    end

    def extract_metadata(workflow)
    end

    def extract_rdf_structure(workflow)
      nil
    end

    # End Instance Methods

  end
end
