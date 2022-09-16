require 'uri'
require 'net/http'
require 'json'
require_relative 'response'

class Api
  DEFAULT_HEADER = {"Content-Type" => "application/json"}

  attr_reader :base_url
  def initialize(base_url)
    @base_url = base_url
  end
  
  def make_request(path, method:, query: {}, body: nil)
    response = nil
    uri = URI("#{base_url}/#{path}")
    uri.query = URI.encode_www_form(query)
    case method
    when :get
      response = Net::HTTP.get_response(uri)
    when :post
      response = Net::HTTP.post(uri, body.to_json, DEFAULT_HEADER)
    else
      raise StandardError, "Unsoported request method"
    end
    puts response.body
    hashed_response = JSON.parse(response.body)
    return Response.new(hashed_response) if response.code == '301' || response.is_a?(Net::HTTPSuccess)

    raise Response::ResponseError.new response.body
  end
end
