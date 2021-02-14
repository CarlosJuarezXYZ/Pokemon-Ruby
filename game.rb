require_relative "player"
require_relative "battle"
require_relative "pokedex"

# rubocop:disable all
class Game
  include Pokedex
  def start
    welcome
    choose_pokemon
  end
  

  def train
    bot_train = Bot.new
    bot_train.create_pokemon
    while @action != "Leave"
    
     puts"#{@player.name} challenge #{bot_train.name} for training"
     puts"#{bot_train.name} has a #{bot_train.pokemon.name}  level #{bot_train.pokemon.level}"
     puts"What do you want to do now?"
     puts"1. Fight        2. Leave"

     @action = gets.chomp.capitalize

     if @action == "Fight"            
      battle = Battle.new @player, bot_train
      battle.start     
     end
     break
    end
  end

  def challenge_leader 
    leader = Leader.new
    while @action.capitalize != "Leave"
     puts "#{@name} challenge the Gym Leader #{leader.name} for a fight!"
     puts "#{leader.name} has a Onix level  10!"
     puts "What do you want to do now?"
     puts"1. Fight        2. Leave"
     @action = gets.chomp.capitalize
     if @action == "Fight"            
      battle = Battle.new @player, leader
      battle.start     
     end
     break
    end
  end

  def goodbye
    puts "Thanks for playing Pokemon Ruby"
  end

  def menu
  end

  def welcome
    puts"#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#"
    puts"#$#$#$#$#$#$#$                               $#$#$#$#$#$#$#"
    puts"#$##$##$##$ ---        Pokemon Ruby         --- #$##$##$#$#"
    puts"#$#$#$#$#$#$#$                               $#$#$#$#$#$#$#"
    puts"#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#\n\n"
    puts"Hello there! Welcome to the world of POKEMON! My name is OAK!"
    puts "People call me the POKEMON PROF!"
    puts"This world is inhabited by creatures called POKEMON! For some"
    puts"people, POKEMON are pets. Others use them fights. Myself..."
    puts"I study POKEMON as a profession.\n\n"
    puts"First, what is your name?\n\n"
    @name = gets.chomp.capitalize
    @player =  Player.new(@name)
  end
  def choose_pokemon
    puts"Right! So your name is #{@name}!"
    puts"Your very own POKEMON legend is about to unfold! A world of"
    puts"dreams and adventures with POKEMON awaits! Let's go!"
    puts"Here, #{@name}! There are 3 POKEMON here! Haha!"
    puts"When I was young, I was a serious POKEMON trainer."
    puts"In my old age, I have only 3 left, but you can have one! Choose!\n\n"
    puts "1. Bulbasaur    2. Charmander   3. Squirtle\n\n"
    @my_pokemon = gets.chomp.capitalize
    puts "\nYou selected #{@my_pokemon}. Great choice!"
    puts"Give your pokemon a name?"
    @my_pokemon_name = gets.chomp.capitalize
    @my_pokemon_name = @my_pokemon_name == "" ? @my_pokemon : @my_pokemon_name
    
    #Instance pokemon
    @player.create_pokemon(@my_pokemon,@my_pokemon_name)

    puts"#{@player.name},raise your young #{@player.pokemon.name} by making it fight!"
    puts"When you feel ready you can challenge BROCK, the PEWTER's GYM LEADER\n\n"
    while @action != "Exit"
    puts "-------------------------Menu-------------------------------\n\n"
    puts "1. Stats        2. Train        3. Leader       4. Exit"
    print "action: "
    @action = gets.chomp.capitalize
    case @action
      when "Train"
      train
      when "Leader"
      challenge_leader
      when "Stats"        
        @player.pokemon.show_stats
      when "Exit"
      goodbye
      else
      puts "Invalid Action"
    end
   end
 end
end


game = Game.new
game.start
# rubocop:enable all
