class Genre

  @@genres = []

  attr_accessor :genre, :movies

  def initialize(genre)
    @genre = genre
    @movies = []
    @@genres << self
  end # initialize

  def add_movie(movie)
    self.movies << movie unless self.movies.include?(movie)
  end # add_movie

  def self.all
    @@genres
  end # all

end
