require_relative "pokedex"
require_relative "pokemon"
require_relative "player"
require_relative "battle"
# rubocop:disable all
class Pokemon
  attr_reader :name, :species, :type, :stats, :moves, :growth_rate, :stat_effort, :current_move, :life
  attr_accessor :base_exp, :level

  include Pokedex
  def initialize(species, name, level = 1)
    pokemon = POKEMONS[species]
    @name = name
    @species = pokemon[:species]
    @type = pokemon[:type]
    @base_exp = pokemon[:base_exp]
    @effort_points = pokemon[:effort_points]
    @growth_rate = pokemon[:growth_rate]
    @moves = pokemon[:moves]
    @level = level
    @base_stats = pokemon[:base_stats]
    @experience_points = 0
    stats_init
    @effort_values = { hp: 0, attack: 0, defense: 0, special_attack: 0, special_defense: 0, speed: 0 }

    @current_move = nil

    @life = @stats[:hp]

    @current_hit = 1

    @exp = 0
  end
  def stats_init
    @stat_individual_value = rand(0..32).to_i
    @stat_effort_value = 0
    @stat_effort = 0
    @stats = calculate_stat_effort
  end

  def show_stats        
    puts "Name : #{@name}"
    puts "Kind: #{@species}"
    puts "Level: #{@level}"
    puts "Type: #{@type}"
    puts "Stats: "
    puts "HP: #{@stats[:hp]}"
    puts "Attack: #{@stats[:attack]}"
    puts "Defense: #{@stats[:defense]}"
    puts "Special Attack: #{@stats[:special_attack]}"
    puts "Special Defense: #{@stats[:special_defense]}"
    puts "Speed: #{@stats[:speed]}"
    puts "Experience Points: #{@exp}"
  end

  def prepare_for_battle
    @life = @stats[:hp]
    @current_move = nil
  end

  def receive_damage(damage)
    @life -= damage
  end

  def setcurrent_move(move)
    @current_move = move
  end

  def fainted?
    @life <= 0
  end

  def attack(pokemon)     
    
    base_damage = ((2 * @level / 5.0 + 2).floor * @stats[:attack] * MOVES[@current_move][:power] / @stats[:defense])
    base_damage_convert = (base_damage.floor / 50.0).floor + 2
    
    @current_hit = rand(17) == 16 ? 1.5 : 1    
    @multiplicador = 1
    
    puts "--------------------------------------------------"
    puts "#{@name} used #{@current_move}"
    real_damage = base_damage_convert * @current_hit
    
    pokemon.type.each do |n|
      pepe = TYPE_MULTIPLIER.select do |a|
        a[:user] == MOVES[@current_move][:type].to_sym && a[:target] == :"#{n}"
      end
      ala = pepe[0].nil? ? 1 : multiplier_pokemon(pepe[0])            
      real_damage = real_damage * @multiplicador
    end
    pokemon.receive_damage(real_damage)    
    if @current_hit == 1.5
      print "CRITICOO!!"
    end
    puts "And it hit #{pokemon.name} with #{real_damage} damage"      
    puts ""
  end

  def multiplier_pokemon(data)
    case data[:multiplier]
    when 0
      p "It doesn't affect "
      0
    when 0.5
      puts "It's not very effective..."
      0.5
    when 2
      puts "It's super effective!"
      2
    else
      1
    end
  end
  
  def increase_stats(player)
    exp_pokemon = (player.pokemon.base_exp * player.pokemon.level / 7.0).floor
    @exp += exp_pokemon    
    if @exp >= ((6 / 5) * (@level )**3 - (15 * (@level)**2) + (100 * (@level)) - 140)
      @level += 1
      @stats = calculate_stat_effort
      puts "#{@name} reached level #{@level}"
    end    
    puts "#{@name} gained #{@exp} experience points"
  end
  def increment_stat_effort
    @stat_effort_value += 1
    @stat_effort = (@stat_effort_value / 4.0).floor
  end

  def calculate_stat_effort
    {
      hp: calculate_hp(@base_stats[:hp]),
      attack: calculate_rest_stats(@base_stats[:attack]),
      defense: calculate_rest_stats(@base_stats[:defense]),
      special_attack: calculate_rest_stats(@base_stats[:special_attack]),
      special_defense: calculate_rest_stats(@base_stats[:special_defense]),
      speed: calculate_rest_stats(@base_stats[:speed])
    }
  end

  def calculate_hp(value)
    ((2 * value + 1 + @stat_effort) * @level / 100 + @level + 10).floor
  end

  def calculate_rest_stats(value)
    ((2 * value + @stat_individual_value + @stat_effort) * @level / 100 + 5).floor
  end
end
# rubocop:enable all
