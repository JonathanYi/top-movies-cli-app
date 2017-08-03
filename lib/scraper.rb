require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_top_list()
    html = File.read('./fixtures/IMDb_top_250.html')
    index = Nokogiri::HTML(html)
    binding.pry
  end

  def self.scrap_movie_page(movie_url)

  end

end
