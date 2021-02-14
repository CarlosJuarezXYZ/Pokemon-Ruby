require_relative "pokemon"
require_relative "pokedex"
require_relative "player"

class Battle
  include Pokedex

  def initialize(player1, player2)
    # Complete this
    @player1 = player1
    @player2 = player2
    @player1_pokemon = @player1.pokemon
    @player2_pokemon = @player2.pokemon
  end

  # rubocop:disable all
  def start
        
    @player1.pokemon.prepare_for_battle
    @player2.pokemon.prepare_for_battle
    initial_message    
    info_pokemon
    
    until @player1.pokemon.fainted? || @player2.pokemon.fainted?

      @player1.select_move
      @player2.select_move
      
      first = attack_order
      second = first == @player1 ? @player2 : @player1
      
      first.pokemon.attack(second.pokemon)
      second.pokemon.attack(first.pokemon) unless second.pokemon.fainted?
            
      info_hp
                            
      next unless first.pokemon.fainted?
    end
    
    @winner = @player1.pokemon.fainted? ? @player2: @player1
    @loser = @player2.pokemon.fainted? ? @player2 : @player1 
    
    winner_real = @winner.pokemon.name
    loser_real = @loser.pokemon.name
    puts "--------------------------------------------------"
    puts "#{@winner.pokemon.name} WINS!"
    if(winner_real == @player1.pokemon.name.to_s)      
    @player1.pokemon.increase_stats(@loser)
    end
    puts "#{@loser.pokemon.name} DEFEATED!"    
    puts "-------------------Battle Ended!-------------------"    
  end

  def info_hp
    puts "#{@player1.name} #{@player1.pokemon.name} - Level #{@player1.pokemon.level}" 
      puts "HP :  #{@player1.pokemon.life <= 0 ? 0 : @player1.pokemon.life} " 
      puts "#{@player2.name} #{@player2.pokemon.name} - Level #{@player2.pokemon.level}" 
      puts "HP : #{@player2.pokemon.life <= 0 ? 0 : @player2.pokemon.life} " 
  end

  def initial_message
    puts ""
    puts "#{@player1.name} sent out #{@player1_pokemon.name.upcase}!"
    puts "#{@player2.name} sent out #{@player2_pokemon.name.upcase}!"
    puts ""
    puts "-------------------Battle Start!-------------------"
  end

  def info_pokemon
    puts ""
    puts "#{@player1.name} #{@player1_pokemon.name} - Level #{@player1_pokemon.level}"
    puts "HP : #{@player1_pokemon.life}"
    puts "#{@player2.name} #{@player2_pokemon.name} - Level #{@player2_pokemon.level}"
    puts "HP : #{@player2_pokemon.life}"
    puts ""
  end

  def attack_order
    compare = MOVES[@player1.pokemon.current_move][:priority] <=> MOVES[@player2.pokemon.current_move][:priority]
    case compare
    when -1 then @player1
    when 1 then @player2
    when 0 then @player1
    end
  end  
  # rubocop:enable all
end
