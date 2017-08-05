class Director

  extend Concerns::Findable
  include Concerns::Addable

  @@directors = []

  attr_accessor :name, :movies

  def initialize(name)
    @name = name
    @movies = []
    @@directors << self
  end # initialize

  def self.all
    @@directors
  end # all

end
