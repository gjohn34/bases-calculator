#//////////////////////////////////////////////////////////
# => USER INPUT

def get_value
  puts "What is your value?"
  value = gets.chomp
end

def get_from_base
  puts "what base are you converting from?"
  from_base = gets.chomp.to_i
end

def get_to_base
  puts "what base are you converting to?"
  to_base = gets.chomp.to_i
end

#calculations will require our value that we are converting, and the bases we
# => are converting to and from
def get_user_input
  value = get_value
  from_base = get_from_base
  to_base = get_to_base
  return value, from_base, to_base
end

#////////////////////////////////////////////////////////
# => VALIDATING USER INPUT
#for literal comparisions of strings we need to split our value into an array.
# => instead of just doing a .split in the calculator method I have provided a
# => separate methods as I intend to take it further by being able to accept
# => values that can be partitioned into more than 1 digit elements. As in
# => 10+ base that doens't use alphabet replacements but use 10,11,12 etc as I
# => have seen some filthy heathens do it that way and want to accomadate for
# => these use-cases.
def get_split_value_array_string(value_array_string)
  return value_array_string.split('')
end

# taking the value of our split string and checking for characters to replace.
# => then if that value is greater than the from_base we assert that it is not possible
def is_possible?(value_array_string, from_base, library)
  decimal_value_of_hex_string = get_decimal_value_of_hex_strings(value_array_string, library)
  for number in decimal_value_of_hex_string
    if number.to_i >= from_base
      return false
    end
  end
  return true
end

#said assertion. There is a prettier way to log to console but i'm lazy.
def raise_error(possible, value, from_base)
  if possible == false
    raise "Are you sure that is right? #{value} just doesn't look like base #{from_base}"
  end
end


#///////////////////////////////////////////////////////
# => CONVERTING FROM_BASE TO BASE10 THEN CONVERTING TO TO_BASE

#we take our values and reverse them for readability. Starting from the left hand
# => side, we multiply the value by the power of each base
def convert_to_decimal_array(value_array_string, from_base)
  index = 0
  value_array_integer = value_array_string.map { |e| e.to_i }.reverse
  for element in value_array_integer
    value_array_integer[index] = element * (from_base**index)
    index +=1
  end
  return value_array_integer
end

#taking our array of multiplied values, we sum and return the total, could of
# => saved a step and just .reduced in the previous method to multipy but
# => decided to keep it separate. Might reduce further later.
def get_sum_value_array(value_array_integer)
  sum_value_of_array = value_array_integer.reduce(:+)
  return sum_value_of_array
end

#taking the base10 value, we can start our division of the to_base.
def divide_new_value_by_to_base(sum_value_of_array, to_base, library)
  copy_of_sum_value_of_array = sum_value_of_array
  value_array_string = []
  until copy_of_sum_value_of_array < to_base
    value_array_string.push(copy_of_sum_value_of_array % to_base)
    copy_of_sum_value_of_array /= to_base
  end
  value_array_string.push(copy_of_sum_value_of_array)
  value_array_string = value_array_string.reverse
  if to_base > 10
    return convert_to_above_ten_base(value_array_string, to_base, library)
  else
    return to_base_array_as_integer = value_array_string.join
  end
end

#taking our new array of values we will now convert any values greater than 9
# => to an alphabetic character.
def convert_to_above_ten_base(value_array_string, to_base, library)
  decimal_value_array_string = []
  for element in value_array_string
    for symbol in library
      if element == library.index(symbol)
        decimal_value_array_string.push(symbol)
        break
      end
    end
  end
  return decimal_value_array_string.join
end

#if from_base is >10 then this is the method that includes required methods
def convert_from_below_ten_to_new_base(value_array_string, from_base, to_base, library)
  decimal_array_integer = convert_to_decimal_array(value_array_string, from_base) #correct
  sum = get_sum_value_array(decimal_array_integer) #correct
  new_base_value = divide_new_value_by_to_base(sum, to_base, library)
end

#/////////////////////////////////////////////////////////
# => CONVERTING HEXADECIMAL TO DECIMAL THEN CONVERTING TO CHOSEN BASE

#if our from_base is >10 then we loop and replace alphabetic characters with
# => numerals
def get_decimal_value_of_hex_strings(split_value_array_string, library)
  decimal_value_array_string = []
  for element in split_value_array_string
    for symbol in library
      if element == symbol
        decimal_value_array_string.push(library.index(symbol).to_s)
        break
      end
    end
  end
  return decimal_value_array_string
end

#if from_base is >10 we are taking an additional two steps which involve
# => assigning values to/from alph. is possible to convert to one method with
# => if statements to reduce amount of methods. will redo later.
def convert_from_above_ten_base_to_to_base(split_value_array_string, from_base, to_base, library)
  decimal_value_array_string = get_decimal_value_of_hex_strings(split_value_array_string, library)
  decimal_array_integer = convert_to_decimal_array(decimal_value_array_string, from_base)
  sum = get_sum_value_array(decimal_array_integer)
  divide_new_value_by_to_base(sum, to_base, library)
end

#////////////////////////////////////////////////////////////
#MEAT AND POTATOES

def calculator(rosetta_stone)
  value, from_base, to_base = get_user_input
  split_value_array_string = get_split_value_array_string(value)
  possible = is_possible?(split_value_array_string, from_base, rosetta_stone)
  raise_error(possible, value, from_base)

  from_base <= 10 ? convert_from_below_ten_to_new_base(split_value_array_string, from_base, to_base, rosetta_stone)
   : convert_from_above_ten_base_to_to_base(split_value_array_string, from_base, to_base, rosetta_stone)
end
