class CLI

  BASE_PATH = "http://www.imdb.com"

  def run
    create_movie_list
    add_movie_details
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
      details_hash[:director] = to_director_object_array(details_hash[:director])

      movie.get_movie_details(details_hash)
    end
  end # add_movie_details

  def to_genre_object_array(array)
    array.collect {|genre| Genre.find_or_create_by_name(genre)}
  end # to_genre_object_array

  def to_director_object_array(array)
    array.collect {|genre| Director.find_or_create_by_name(genre)}
  end # to_director_object_array

end
