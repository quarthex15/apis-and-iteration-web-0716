require 'rest-client'
require 'json'
require 'pry'

def get_character_hash_from_api
  #make the web request
  #all_characters = RestClient.get("http://www.swapi.co/api/people/")
  #initial_hash = JSON.parse(all_characters)
  #pages = initial_hash["count"]

  character_hashes = []

  last_page = 0
  page_number = 1
  until last_page == 1

    all_characters_on_page = RestClient.get("http://www.swapi.co/api/people/?page=#{page_number}")
    page_number += 1
    page_character_hash = JSON.parse(all_characters_on_page)
    #binding.pry
    last_page = 1 if page_character_hash["next"] == nil

    page_character_hash["results"].each do |char|
      character_hashes << char
    end
    #binding.pry
  end

  character_hashes
end


def find_character(character, characters_array)
  #binding.pry
  character_data = characters_array.select do |char|
    #binding.pry
    character==char["name"].downcase
  end
  #binding.pry
end

def get_film_hashes_from_api(character_data)
  #binding.pry
  film_urls = character_data[0]["films"]
  film_urls.collect do |film_url|
    JSON.parse(RestClient.get(film_url))
  end
end
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.


def parse_character_movies(films_array)
  output_array = []
  films_array.each do |film|
    #binding.pry
    title = film["title"]
    director = film["director"]
    episode_number = film["episode_id"]
    year_released = film["release_date"][0..3]

    #Put puts here'

    output_array << "Episode #{episode_number}: #{title}, directed by #{director}, released in #{year_released}"
  end
  #binding.pry
  output_array.sort_by! do |film|
    film[(film.length-4)..(film.length-1)]
  end
  puts output_array
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  characters_array = get_character_hash_from_api
  character_data = find_character(character, characters_array)
  films_array = get_film_hashes_from_api(character_data)
  parse_character_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
