#!/usr/bin/env ruby

@lives          = 3
@police_rating  = 0
@lung_capacity  = 2

def how_many_lives_left
  puts "You have #{@lives} left."
end

def how_much_police_rating
  puts "You have a police rating of #{@police_rating}."
end

def how_much_lung_capacity
  if @lung_capacity < 1
    puts "YOU ARE OUT OF BREATH"
  end
end

def show_player_stats
  how_many_lives_left
  how_much_police_rating
  how_much_lung_capacity
  puts ""
end

def welcome_to_game
  puts "Hi, welcome to the game!"
  show_player_stats
end

def prompt_player_for_what_to_do
  puts  "What would you like to do?"
  puts  "1: Shoot something"
  puts  "2: Run away"
  puts  ""

  input = gets.strip
  puts  "You said: #{input}"
  puts  ""

  return input
end

def react_to_what_player_typed(input)
  case input
  when "1"
    puts "You shot someone! He's bleeding."
    @police_rating += 2
  when "2"

    if @lung_capacity < 2
      puts "You can't run, you're out of breath!!"
      # does NOT reduce police rating
      # does NOT reduce lung capacity
    else
      if @police_rating > 0
        puts "You run and hide behind a dumpster."
        @police_rating -= 2
      else
        puts "You hit your head on a lamppost."
      end

      @lung_capacity -= 2
    end

  else
    puts "You just stand there."
  end

  puts ""
end

def send_police
  if @police_rating > 3
    puts "THE POLICE CAME AFTER YOU!"
    puts ""
    @lives          = @lives - 1
    @police_rating  = 0
  end
end

def recover_breath(input)
  if input != "2"
    @lung_capacity = @lung_capacity + 1
  end
end

def prompt_and_react
  input = prompt_player_for_what_to_do
  if input == "exit"
    puts "Exiting game..."
    exit
  end
  react_to_what_player_typed(input)
  recover_breath(input)
  send_police
  show_player_stats
end

def end_game
  puts "###################"
  puts "###  YOU DEAD  ###"
  puts "###################"
  puts ""
end

def game_loop
  loop do
    prompt_and_react
    break if @lives < 1
  end
end

# THE GAME
welcome_to_game
game_loop
end_game
