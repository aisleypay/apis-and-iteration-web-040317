require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  films = nil

  character_hash["results"].each { |character_api|
    films = character_api["films"] if character_api["name"].downcase == character
  }

  films_hash = []
  films.each { |film|
    films_hash.push(JSON.parse(RestClient.get(film)))
  }

  films_hash
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def attribute_converter (attribute, info)
  puts "#{attribute.capitalize}:"
  puts
  info.each { |individual_subject|
    puts JSON.parse(RestClient.get(individual_subject))["name"]
  }
  puts
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each { |film|
    puts "*" * 30
    film.each { |attribute, info|
      case attribute
      when "opening_crawl"
        puts "#{attribute.capitalize}:\n\n#{info.center(60)}"
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

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
