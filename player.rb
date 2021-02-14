require_relative "pokemon"
require_relative "pokedex"
class Player
  attr_reader :name, :pokemon

  def initialize(name)
    @name = name
  end

  def create_pokemon(species, name, level = 1)
    @pokemon = Pokemon.new(species, name, level)
  end

  def select_move
    puts ""
    puts "#{@name}, select your move :"
    puts @pokemon.moves
    move = gets.chomp
    @pokemon.setcurrent_move(move)
    puts ""
  end
end

class Bot < Player
  include Pokedex

  def initialize
    super @name = "Team Rocket"
  end

  def create_pokemon
    pokemon = POKEMONS.keys.sample
    species = POKEMONS[pokemon][:species]
    level = rand(1..3).to_i
    @pokemon = Pokemon.new(species, species, level)
  end

  def select_move
    moves = POKEMONS[@pokemon.name][:moves]
    moves_pokemon = MOVES[moves.sample][:name]
    @pokemon.setcurrent_move(moves_pokemon)
  end
end

class Leader < Player
  include Pokedex
  def initialize
    super @name = "El BROCK"
    @pokemon = Pokemon.new("Onix", "Onix", 10)
  end

  def select_move
    moves = POKEMONS[@pokemon.name][:moves]
    moves_pokemon = MOVES[moves.sample][:name]
    @pokemon.setcurrent_move(moves_pokemon)
  end
end

