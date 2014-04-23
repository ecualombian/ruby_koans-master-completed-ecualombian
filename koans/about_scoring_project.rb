require File.expand_path(File.dirname(__FILE__) + '/neo')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate threquire "about_scoring_project"

# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.


def score(dice)
  count = 0
  test_illegal_input(dice) # tests for valid input
  current_roll = Hash.new
  score_count = Hash.new
#  n_max = dice.size
  possible = [1, 2, 3, 4, 5, 6]
  #values = [100, 0, 0, 0, 50, 0]
  possible.each {|item| current_roll[item] = 0}
  possible.each {|item| score_count[item] = 0}
  score_count[1] = 100
  score_count[5] = 50
#  score_count = current_roll.inject({}) {|h (k, v)| h[k] = values[k] ; h}
#  puts score_count
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
    count += (key * 100) end
 count += value%3 * score_count[key]
 
  # for testing
 # puts ("This is the conditional - #{score_count.keys.include?(key)}
#  This is the multiplication - #{value * score_count[key]}
#  This is the key - #{key}, 
#  This is the value - #{value}, 
#  This is score_count[key] - #{score_count[key]}
#  and 
#  This is count - #{count}")
 end}
 return count
 

# values.each {|item| count += item * hash.fetch}
 
# array_of_count_of_n = dice.select { |item| item == 5 }
 #if count_of_fives.size >= 3
  # return count = count_of_fives.size
  
#if (dice.first == nil) 
   # return count
#  elsif((dice.size == 1) && (dice.first == 5))
 #   return count += 50
#  elsif((dice.size == 1) && (dice.first == 1))
 #   return count += 100
    
#    return count +=100  if (dice.pop == 1) || return count +=50 if (dice.pop == 5)
   #   if (value == 1) 
    #    return count += 100
     # elsif (value == 5) 
      #    return count += 50
  #  end
  #end
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
  end


class NotADiceError < RuntimeError

end

class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
    assert_equal 1100, score([1,1,1,1])
    assert_equal 1200, score([1,1,1,1,1])
    assert_equal 1150, score([1,1,1,5,1])
  end

end
