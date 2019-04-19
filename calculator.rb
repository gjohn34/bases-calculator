require_relative 'methods'

rosetta_stone = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H",
          "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",
          "W", "X", "Y", "Z"]



def calculator(rosetta_stone)
  value = get_value
  from_base = get_from_base
  to_base = get_to_base
  split_value_array_string = get_split_value_array_string(value)
  possible = is_possible?(split_value_array_string, from_base, rosetta_stone)
  raise_error(possible, value, from_base)

  from_base <= 10 ? convert_from_below_ten_to_new_base(split_value_array_string, from_base, to_base, rosetta_stone)
   : convert_from_above_ten_base_to_to_base(split_value_array_string, from_base, to_base, rosetta_stone)
end


puts calculator(rosetta_stone)
