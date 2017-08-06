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

    input = ""
    while input != 4
      input = gets.strip.to_i
      if input == 1
        display_movies
      elsif input == 2
        display_genres
      elsif input == 3
        display_directors
      end
    end
  end # interface

  def display_movies
    Movie.all.each_with_index do |movie, index|
      puts "#{index+1}: #{movie.name} #{movie.year}".colorize(:red)
    end

    puts "Select a movie by number for movie details."
    puts "Select 0 to go back to main menu."
    input = gets.strip.to_i
  end # display_movies

  def display_movie_details
  end # display_movie_details

  def show_details(movie)

  end # print_details

end
