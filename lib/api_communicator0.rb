require 'rest-client'
require 'json'
require 'pry'

def get_movies_from_api(subject, specific_subject)
  subject_hash = nil

  case subject
  when "people"
    all_subjects = RestClient.get('http://www.swapi.co/api/people/')
      subject_hash = JSON.parse(all_subjects)

  when "planets"
    all_subjects = RestClient.get('http://www.swapi.co/api/planets/')
      subject_hash = JSON.parse(all_subjects)
  when "vehicles"
    all_subjects = RestClient.get('http://www.swapi.co/api/vehicles/')
      subject_hash = JSON.parse(all_subjects)
  when "species"
    all_subjects = RestClient.get('http://www.swapi.co/api/species/')
      subject_hash = JSON.parse(all_subjects)
  when "starships"
    all_subjects = RestClient.get('http://www.swapi.co/api/starships/')
      subject_hash = JSON.parse(all_subjects)
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

def show_character_movies(subject, specific_subject)
  films_hash = get_movies_from_api(subject, specific_subject)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
