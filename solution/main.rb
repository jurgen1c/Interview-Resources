require_relative 'api'

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