def welcome
  "Get your Star Wars informtion here!"
end

def get_subject_from_user
  puts "What would you like to learn about Star Wars?"
  subject_array = %w(people planets vehicles species starships)
  puts "You can only choose: people, planets, vehicles, species, or starships"

  subject = gets.chomp.downcase

  until subject_array.include?(subject)
    puts "Sorry, that's not valid try again"
    subject = gets.chomp.downcase
  end

  subject
end

def get_subject_specific_from_user(get_subject_from_user)
  puts "What or which specific #{get_subject_from_user} would you like to know about?"

  subject_specfic = gets.chomp.downcase
end
