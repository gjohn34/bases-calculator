#//////////////////////////////////////////////////////////
# => LIBRARY OF VALUES

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
#////////////////////////////////////////////////////////
# => VALIDATING USER INPUT
def get_split_value_array_string(value_array_string)
  return value_array_string.split('')
end

def is_possible?(value_array_string, from_base)
  for number in value_array_string
    if number.to_i >= from_base
      return false
    end
  end
  return true
end

def raise_error(possible, value, from_base)
  if possible == false
    raise "Are you sure that is right? #{value} just doesn't look like base #{from_base}"
  end
end
#///////////////////////////////////////////////////////
# => CONVERTING FROM BELOW BASE10 TO BELOW BASE10
def convert_to_decimal_array(value_array_string, from_base)
  index = 0
  value_array_integer = value_array_string.map { |e| e.to_i }.reverse
  for element in value_array_integer
    value_array_integer[index] = element * (from_base**index)
    index +=1
  end
  return value_array_integer
end

def get_sum_value_array(value_array_integer)
  sum_value_of_array = value_array_integer.reduce(:+)
  return sum_value_of_array
end

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
    puts 'greater than 10'
    return convert_to_above_ten_base(value_array_string, to_base, library)
  else
    return to_base_array_as_integer = value_array_string.join
  end
end

def convert_to_above_ten_base(value_array_string, to_base, library)
  decimal_value_array_string = []
  puts value_array_string
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

def convert_from_below_ten_to_new_base(value_array_string, from_base, to_base, library)
  decimal_array_integer = convert_to_decimal_array(value_array_string, from_base) #correct
  sum = get_sum_value_array(decimal_array_integer) #correct
  new_base_value = divide_new_value_by_to_base(sum, to_base, library)
end

#/////////////////////////////////////////////////////////
# => CONVERTING HEXADECIMAL TO DECIMAL THEN CONVERTING TO CHOSEN BASE

def get_decimal_value_of_hex_strings(split_value_array_string, library = rosetta_stone)
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

def multiply_values_in_string_by_base(decimal_value_array_string, from_base)
  decimal_value_array_integer = decimal_value_array_string.map { |e| e.to_i }.reverse
  index = 0
  for element in decimal_value_array_integer
    decimal_value_array_integer[index] = element * (from_base**index)
    index +=1
  end
  return decimal_value_array_integer
end

def convert_from_above_ten_base_to_to_base(split_value_array_string, from_base, to_base, library)
  decimal_value_array_string = get_decimal_value_of_hex_strings(split_value_array_string, library)
  decimal_array_integer = multiply_values_in_string_by_base(decimal_value_array_string, from_base)
  sum = get_sum_value_array(decimal_array_integer)
  divide_new_value_by_to_base(sum, to_base, library)
end


#multiply element values with base from
#sum
#to convert to to_base
  #divide sum by to_base values
