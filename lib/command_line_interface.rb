def welcome
  puts "Welcome! May the force be with you!"
  # puts out a welcome message here!
end

def get_character_from_user
  puts "please enter a character"
  character = gets.chomp
  character.downcase
  # use gets to capture the user's input. This method should return that input, downcased.
end

get_character_from_user
