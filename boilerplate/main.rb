require 'uri'
require 'net/http'
require 'json'
require 'rspec/autorun'

module FieldHelper
  # Code that should be added by candidate below
  def self.included(base)
    # Add code for base to extend ClassMethods
  end
  
  module ClassMethods
    def create_helpers(hash)
      # Add code below to have the create_helper method create accessor and manipulation methods for each 
      # key value pair in the hash. The method created should have the key as name and return the value.
      # Method should be able to recieve arguments and take a block that will that will recieve the value 
      # and any arguments given.
      # Consider the value of a key may also be a hash or array of hashes.
      puts "Implement me"
    end
  end
end

class Response
  include FieldHelper
  class ResponseError < StandardError; end

  def initialize(body)
    @body = body
    # Call the create_helpers method on the body of response
  end
end

class Api
  # Be sur eto make your instance variables readable
  def initialize(base_url)
    # Assign base url as instance variable.
  end

  def make_request(path, method:, query: {}, body: nil)
    # Populate the method so it can make either a GET or POST request (depending on method argument)
    # to the path provided. Should be able to pass query to GET and body to a POST. Return the response
    # using the Response class so it will have helper methods for each key/value pair.
    # Should raise an error if request returns unsuccesful response code
  end
end

u = Api.new('https://pokeapi.co/api/v2')

poke_data = u.make_request('pokemon', method: :get)
puts poke_data.count
puts poke_data.results do |data|
  data.map { |v| v['name'] }
end

puts poke_data.results_1_name
new_base_url = poke_data.results_1_url { |url| URI(url) }

j = Api.new("#{new_base_url.scheme}://#{new_base_url.host}")
new_data = j.make_request(new_base_url.path[1..-1], method: :get)
puts '############ MOVES '
puts new_data.moves
puts '##################### SPRTIE'
puts new_data.sprites_back_default
puts '########################## MOVE 0 NAME'
puts new_data.moves_0_move_name

RSpec.describe 'Test response helpers' do
end