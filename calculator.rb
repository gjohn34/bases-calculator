# => ie check if any digits are greater than base (no four or greater in base 4
      # and no 67s in base 66). if base >10 split digits up in twos?
#if number is possible
# => until number is less than base ie number is 3 or less in base4
    #divide number and push remainder to an array for storage
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

def is_possible?(value, from_base)
  for number in value
    if number.to_i >= from_base
      return false
    end
  end
  return true
end

def conversion_from_ten(value, to_base)
  library = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H",
             "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",
             "W", "X", "Y", "Z"]
  numbers = value.to_i
  new_array = []
  until numbers < to_base
     new_array.push(numbers % to_base)
     numbers /= to_base
  end
  new_array.push(numbers)
  for element in new_array
    if element > 9
      new_array[new_array.index(element)] = library[element]
    end
  end
  return new_array.reverse.join
end

def raise_error(possible, value, from_base)
  if possible == false
    raise "Are you sure that is right? #{value} just doesn't look like base #{from_base}"
  end
end

def get_array(copy_of_value, new_array, index)
  until copy_of_value.size < 2 do
    new_array.push(copy_of_value.slice!(index,2).join.to_i)
  end
  #flip it back again
  return new_array.reverse!
end

def sum_array(new_array, from_base)
  index = 0
  #then do our multiplication
  for element in new_array
    new_array[index] = element * (from_base**index)
    index +=1
  end
  #sum the number then we have our base10 number from our base11+
  sum = new_array.reduce(:+)
  return sum
end

def need_a_good_name_for_this_one(new_array, copy_of_value, index, from_base)
  new_array = get_array(copy_of_value, new_array, index)
  new_array.push(copy_of_value[0]) if index == 1
  possible = is_possible?(new_array, from_base)
  raise_error(possible, new_array.join, from_base)
  sum_array(new_array, from_base)
end

def convert_above_ten_to_ten_with_ints(value, from_base)
  #take a copy of the value and split it into an array then reverse (sigh)
  copy_of_value = value.digits.reverse
  new_array = []
  #if the value is even we can start splitting the array into elements
  if value.to_s.size % 2 == 0
    need_a_good_name_for_this_one(new_array, copy_of_value, 0, from_base)
  else
    need_a_good_name_for_this_one(new_array, copy_of_value, 1, from_base)
  end
end

def get_letters
  puts "letters? y/n"
  input = gets.chomp
end

def is_letters(input)
  if input == "y" || input == "n"
    letters = true if input == "y"
    letters = false if input == "n"
  else
    letters = false
  end
  return letters
end

def conversion_above_ten_to_ten_with_letters(value,from_base)
  #if value is a from_base above ten
  # if the values are in integerswe can either partition the value into separate elements by taking the length
            # of base (ie base11 is 2 and
            #base 101 is 3) and then do our multiplication by powers to convert to base ten
            # 113 base 16 is (13*16^0)+(1*16^1)
            #then convert that number to our higher base
  # => or if values contain characters we can create an array of 0..9A..F then assign those numbers a value
            #then do our multiplication by powers
            # 9F1Base16 => (1*16^0)+(15*16^1)+(9*16^2) =>1+240+2304 =>2454
            #then we can convert to our higher base
  library = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H",
             "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",
             "W", "X", "Y", "Z"]
  new_value =  value.split('')
  new_array = []
  for character in new_value
    for symbol in library
      if character == symbol
        new_array.push(library.index(symbol))
        break
      end
    end
  end
  possible = is_possible?(new_array, from_base)
  raise_error(possible, value, from_base)
  sum_array(new_array.reverse, from_base)
end


def final_above_ten(value, from_base, to_base)
  letters = is_letters(get_letters)
  if letters == true
    #converting hex
    new_numbers = conversion_above_ten_to_ten_with_letters(value, from_base)
    return conversion_from_ten(new_numbers, to_base)
  else
    new_numbers = convert_above_ten_to_ten_with_ints(value.to_i, from_base)
    return conversion_from_ten(new_numbers, to_base)
  end
end


def calculator
  #take an input from user
  value = get_value
  #ask for converting from base
  from_base = get_from_base
  #ask for converting to base
  to_base = get_to_base
  #check if number given is possible using from base
  possible = is_possible?(value.split(''), from_base)
  raise_error(possible, value, from_base)
  # => ie check if any digits are greater than base (no four or greater in base 4
        # and no 67s in base 66). if base >10 split digits up in twos?
  # => until number is less than base ie number is 3 or less in base4
      #divide number and push remainder to an array for storage
  #if base conversion is less than 10

  from_base <= 10 ? conversion_from_ten(value, to_base) : final_above_ten(value, from_base, to_base)

end


puts calculator

#puts "value: #{value}"
#puts "new_array: #{new_array}, reversed: #{new_array.reverse}"
# puts "copy_of_value: #{copy_of_value}"
