require_relative '../config/environment.rb'

class CLI

  BASE_PATH = "http://www.imdb.com"

  def run
    create_movie_list
    add_movie_details
    #debug
    puts "Welcome to Top Movies (Top list from IMDb)"
    interface
  end # run

  def create_movie_list
    movie_array = Scraper.scrape_top_list('http://www.imdb.com/chart/top')
    Movie.create_from_collection(movie_array)
  end # create_movie_list

  def add_movie_details
    Movie.all.each do |movie|
      #binding.pry
      details_hash = Scraper.scrape_movie_page(BASE_PATH + movie.url)
      details_hash[:genre] = to_genre_object_array(details_hash[:genre])
      details_hash[:genre].each {|genre| genre.add_movie(movie)}
      details_hash[:director] = to_director_object_array(details_hash[:director])
      details_hash[:director].each {|director| director.add_movie(movie)}

      movie.get_movie_details(details_hash)
    end
  end # add_movie_details

  def to_genre_object_array(array)
    array.collect {|genre| Genre.find_or_create_by_name(genre)}
  end # to_genre_object_array

  def to_director_object_array(array)
    array.collect {|genre| Director.find_or_create_by_name(genre)}
  end # to_director_object_array

  def debug
    binding.pry
  end

  def interface
    puts "Please select an option by number"
    puts "1: To display top #{Movie.all.length} movies."
    puts "2: To display genres."
    puts "3: To dsiplay Directors."
    puts "4: To exit"

    input = -1
    while input != 4
      input = gets.strip.to_i
      binding.pry
      if input == 1
        display_movies
      # elsif input == 2
      #   display_genres
      # elsif input == 3
      #   display_directors
      elsif input == 4
      end
    end
  end # interface

  def valid_input?(input, range)
    (1..range).include?(input)
  end

  def display_movies
    Movie.all.each_with_index do |movie, index|
      puts "#{index+1}: #{movie.name} #{movie.year}".colorize(:red)
    end

    puts "Select a movie by number for movie details."
    puts "Type 0 to go back to main menu."
    input = ""
    while input != 0
      input = gets.strip.to_i
      if valid_input?(input, Movie.all.length)
        display_movie_details(Movie.all[input-1])
      end
    end
  end # display_movies

  def display_movie_details(movie)
    puts "#{movie.name}".colorize(:blue) + " #{movie.review_rating}".colorize(:yellow) + "/10"
    puts " Run Time: ".colorize(:light_blue) + movie.runtime
    puts " Released: ".colorize(:light_blue) + movie.release
    puts " Director(s): ".colorize(:light_blue) + movie.director.collect {|genre| genre.name}.join(", ")
    puts " Genre(s): ".colorize(:light_blue) + movie.genre.collect {|genre| genre.name}.join(", ")
    puts " Run Time: ".colorize(:light_blue) + movie.runtime
    puts " Storyline: ".colorize(:light_blue) + movie.storyline
    puts ""
    puts "Type 0 for main menu, 1 to go back to select another movie:"
    input = ""
    while input !=1 || input !=0
      input = gets.strip.to_i
      if input == 0
        interface
      elsif input == 1
        display_movies
      end
    end
  end # display_movie_details

end
