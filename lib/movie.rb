class Movie
  @@movie_list = []
  puts "Movie"
  attr_accessor :title, :year, :url

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
  end # end of get_movie_details

  def self.all
    @@movie_list
  end # end of all

end
