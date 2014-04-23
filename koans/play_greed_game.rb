#!/usr/bin/env ruby
# -*- ruby -*-

class Player
	attr_reader :name
	def initialize(name)
		@name = name
	end

end
class Game
	attr_reader :players

	def initialize(number_of_players)
		@players = Array.new(number_of_players)
	end
	
	def score(dice)
  count = 0
  test_illegal_input(dice) # tests for valid input
  current_roll = Hash.new
  score_count = Hash.new
  possible = [1, 2, 3, 4, 5, 6]
  possible.each {|item| current_roll[item] = 0}
  possible.each {|item| score_count[item] = 0}
  score_count[1] = 100
  score_count[5] = 50
  dice.each {|item| 
   (if score_count.keys.include?(item) 
   current_roll[item] += 1 end)
   }
  # puts "This - #{current_roll } - is the current_roll"
  # puts "This - #{score_count} - is the score_count"
 current_roll.each {|key, value| 
  if score_count.keys.include?(key) 
  	if (value > 2 && key == 1)
  		count += 1000 end
  if (value > 2 && key !=1)
    count += (key * 100) end;
    count += value%3 * score_count[key]
end
}
 return count
end

  def test_illegal_input(dice)
  array = dice
   if (Array != array.class) 
    raise NotADiceError.new("This is not a dice.")
  elsif (array.size > 5) 
      raise NotADiceError.new("Trying to cheat with too many die?")
#  elsif (array == []) 
#   return 0 
# wouldn't work in exception method, perhaps shouldn't be here?
  else array.each do |item|
        next if ((0 < item) && (item < 7))
        raise NotADiceError.new("What's with the funky #{item} die?")
    end
end

	#def has_players?
#		if players.empty?
#			puts "There are no players right now."
#		else players.size
#		end
#	end
end
