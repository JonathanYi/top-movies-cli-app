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

  def interface
    puts ""
    puts "Please select an option by number"
    puts "1: To display top #{Movie.all.length} movies."
    puts "2: To display genres."
    puts "3: To dsiplay Directors."
    puts "4: To exit"

    #input = 0
    #while !(input == 4)
    #until input == 4
      input = gets.strip.to_i
      if input == 1
        display_movies(Movie.all)
      elsif input == 2
        display_genre_or_director_list(Genre.all)
      elsif input == 3
        display_genre_or_director_list(Director.all)
      # elsif input == 4
      #   binding.pry
      #   break #puts "this is happening"
      end
    #end
  end # interface

  def get_valid_input(range)
    input = gets.strip.to_i
    input if valid_input?(input, range)
  end

  def valid_input?(input, range)
    (1..range).include?(input)
  end # valid_input?

  def display_movies(array)
    puts ""
    array.each_with_index do |movie, index|
      puts "#{index+1}: #{movie.name} #{movie.year}".colorize(:red)
    end

    puts "Select a movie by number for movie details."
    puts "Type 0 to go back to main menu."
    input = ""
    #while !(input == 0)
    #until input == 0
      input = gets.strip.to_i
      if input == 0
        interface
      elsif valid_input?(input, array.length)
        display_movie_details(array[input-1])
      end
    #end
  end # display_movies

  def display_movie_details(movie)
    puts ""
    puts "#{movie.name}".colorize(:red) + " #{movie.review_rating}".colorize(:yellow) + "/10"
    puts " Run Time: ".colorize(:light_blue) + movie.runtime
    puts " Released: ".colorize(:light_blue) + movie.release
    puts " Director(s): ".colorize(:light_blue) + movie.director.collect {|genre| genre.name}.join(", ")
    puts " Genre(s): ".colorize(:light_blue) + movie.genre.collect {|genre| genre.name}.join(", ")
    puts " Run Time: ".colorize(:light_blue) + movie.runtime
    puts " Storyline: ".colorize(:light_blue) + movie.storyline
    puts ""
    # puts "Type 0 to go back to main menu:"
    # input = ""
    # while input != 0
    #   input = gets.strip.to_i
    #   if input == 0
    #     interface
    #   end
    # end
  end # display_movie_details

  def display_genre_or_director_list(array)
    puts ""
    array.each_with_index do |value, index|
      puts "#{index+1}: " + "#{value.name}".colorize(:red)
    end

    puts "Select an item by number to display list of movies."
    puts "Type 0 to go back to main menu."
    input = ""
    while !(input == 0)
      input = gets.strip.to_i
      if input == 0
        interface
      elsif valid_input?(input, array.length)
        display_movies(array[input-1].movies)
      end
    end
  end # display_genre_or_director_list

end
