class Director

    @@genres = []

    attr_accessor :director, :movies

    def initialize(genre)
      @director = genre
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
