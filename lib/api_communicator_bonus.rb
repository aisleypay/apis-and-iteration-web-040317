require 'rest-client'
require 'json'
require 'pry'

def get_movies_from_api(subject, specific_subject)
  subject_hash = nil

  url = 'http://www.swapi.co/api/' + subject
  all_subjects = RestClient.get(url)
  subject_hash = JSON.parse(all_subjects)

  until subject_hash["next"] == nil
    all_subjects = RestClient.get(subject_hash["next"])
    next_page = JSON.parse(all_subjects)

    next_page["results"].each { |e| subject_hash["results"] << e }
    subject_hash["next"] = next_page["next"]
  end

  films = nil

  subject_hash["results"].each { |subject_api|
    films = subject_api["films"] if subject_api["name"].downcase == specific_subject
  }

  films_hash = []
  films.each { |film|
    films_hash.push(JSON.parse(RestClient.get(film)))
  }

  films_hash
end

def attribute_converter (attribute, info)
  puts "#{attribute.capitalize}:"
  puts
  if info.empty?
    puts "Sorry, none existed in this episode."
    puts
  else
  info.each { |individual_subject|
    puts JSON.parse(RestClient.get(individual_subject))["name"]
  }
  puts

  end
end

def parse_character_movies(films_hash)
  roman = {1 =>"I" , 2 =>"II" , 3 =>"III", 4 =>"IV", 5 =>"V", 6 =>"VI", 7 =>"VII"}

  films_hash.each { |film|
    puts "*" * 30
    film.each { |attribute, info|
      case attribute
      when "episode_id"
        puts "Episode #{roman[info]}"
        puts
      when "opening_crawl"
        puts "Opening Crawl:\n\n#{info.center(60)}"
        puts
      when "characters", "planets" ,"starships", "vehicles", "species"
      attribute_converter(attribute, info)
      else
        puts "#{attribute.capitalize}: #{info}"
        puts
      end
    }
  }

end

def show_character_movies(subject, specific_subject)
  films_hash = get_movies_from_api(subject, specific_subject)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
