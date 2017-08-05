class CLI
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
      details_hash = Scraper.scrape_movie_page(movie.url)

      genre_string_array = details_hash[:genre]
      genre_object_array = genre_string_array.collect {|string| Genre.find_or_create_by_name(string)}
      


    end
  end # add_movie_details


end
