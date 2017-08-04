class Movie
  @@movie_list = []
  puts "Movie"
  attr_accessor
    #movie
    :title, :year, :url,
    #movie details
    :genre, :director, :release, :storyline, :review_rating, :runtime

  def initialize(movie_hash)
    movie_hash.each {|key, value| self.send(("#{key}="), value)}
    @@movie_list << self
  end # end of initialize

  def self.create_from_collection(movie_array)
    movie_array.each {|movie|
      Movie.new(movie)
    }
  end # end of create_from_collection

  def get_movie_details(movie_details)
    #genre is an array
      #for each genre, create genre if it doesn't exist and add self.
      #this may be a separate method
    #director is an array
      #for each director, create a director and add self.
    #assign remaining details to variables
  end # end of get_movie_details

  def self.all
    @@movie_list
  end # end of all

end
