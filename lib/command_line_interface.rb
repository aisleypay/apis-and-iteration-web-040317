def welcome
  "Get your Star Wars informtion here!"
end

puts "What would you like to know about Star Wars"
puts " "

def get_character_from_user
  puts "please enter a character"
  # use gets to capture the user's input. This method should return that input, downcased.
  character_query = gets.chomp.downcase
end
