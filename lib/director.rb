class Director

  extend Concerns::Findable
  include Concerns::Addable

  @@genres = []

  attr_accessor :name, :movies

  def initialize(name)
    @name = name
    @movies = []
    @@genres << self
  end # initialize

  def self.all
    @@genres
  end # all

end
