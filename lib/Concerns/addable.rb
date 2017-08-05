module Concerns::Addable

  def add_movie(movie)
    self.movies << movie unless self.movies.include?(movie)
  end # add_movie

end
