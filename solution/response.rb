require_relative 'field_helper'

class Response
  include FieldHelper
  class ResponseError < StandardError
    def initialize(msg="My default message")
      super
    end
  end

  def initialize(body)
    @body = body
    self.class.create_helpers(body)
  end
end