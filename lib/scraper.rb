# require 'open-uri'
# require 'pry'
require_relative '../config/environment.rb'

class Scraper

  def self.scrape_top_list()
    html = File.read('./fixtures/IMDb_top_250.html')
    index = Nokogiri::HTML(html)

    movie_list_array = index.css("tbody.lister-list tr").collect do |movie|
      {:title => movie.css("td.titleColumn a").text,
       :year => movie.css("td.titleColumn span.secondaryInfo").text,
       :url => movie.css("td.titleColumn a").attr("href").value
      }
    end
  end # scrape_top_list

  def self.scrape_movie_page()
    html = File.read('./fixtures/The Shawshank Redemption (1994) - IMDb.html')
    index = Nokogiri::HTML(html)

    movie_details = {}
    # movie class will create instances of genre and director and add movies to
    # each.
    movie_details[:genre] = index.css("div[itemprop='genre'] a").collect do |genre|
      genre.text
    end

    binding.pry
    #release
    #storyline
    #rating
    #director
    #genre
    #run_time
    movie_details
  end #scrape_movie_page

end
