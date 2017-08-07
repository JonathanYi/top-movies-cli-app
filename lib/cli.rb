require_relative '../config/environment.rb'

class CLI

  BASE_PATH = "http://www.imdb.com"

  def run
    create_movie_list
    add_movie_details
    puts "Welcome to Top Movies (Top list from IMDb)"
    interface
  end # run

  def create_movie_list
    movie_array = Scraper.scrape_top_list('http://www.imdb.com/chart/top')
    Movie.create_from_collection(movie_array)
  end # create_movie_list

  def add_movie_details
    Movie.all.each do |movie|
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

    input = -1
    while !valid_input?(input, 4)
      input = gets.to_i
    end

    if input == 1
      display_movies(Movie.all)
    elsif input == 2
      display_genre_or_director_list(Genre.all)
    elsif input == 3
      display_genre_or_director_list(Director.all)
    elsif input == 4
    end
  end # interface

  def valid_input?(input, range)
    (1..range).include?(input)
  end # valid_input?

  def display_movies(array)
    puts ""
    array.each_with_index do |movie, index|
      puts "#{index+1}: #{movie.name} #{movie.year}".colorize(:red)
    end

    puts "Select a movie by number for movie details."
    puts "Type 0 or just enter to go back to main menu."
    input = -1
    while !(input == 0) && !valid_input?(input, array.length)
      input = gets.to_i
    end

    if input == 0
      interface
    elsif valid_input?(input, array.length)
      display_movie_details(array[input-1])
    end
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
    puts "Type 0 or just enter to go back to main menu."
    input = -1
    while !(input == 0)
      input = gets.to_i
    end

    if input == 0
      interface
    end
  end # display_movie_details

  def display_genre_or_director_list(array)
    puts ""
    array.each_with_index do |value, index|
      puts "#{index+1}: " + "#{value.name}".colorize(:red)
    end

    puts "Select an item by number to display list of movies."
    puts "Type 0 or just enter to go back to main menu."
    input = -1
    while !(input == 0) && !valid_input?(input, array.length)
      input = gets.strip.to_i
    end

    if input == 0
      interface
    elsif valid_input?(input, array.length)
      display_movies(array[input-1].movies)
    end
  end # display_genre_or_director_list

end
