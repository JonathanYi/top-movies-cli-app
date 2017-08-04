class Movie
  @@Movie_List = []
  puts "Movie"
  attr_accessor :title, :year, :url

  def initialize(movie_hash)
    movie_hash.each {|key, value| self.send(("#{key}="), value)}
    @@Movie_List << self
  end

  def self.create_from_collection(movie_array)
    movie_array.each {|movie|
      Movie.new(movie)
    }
  end

  def get_movie_details(movie_details)
  end
end
