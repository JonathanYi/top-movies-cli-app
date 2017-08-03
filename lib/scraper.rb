require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_top_list()
    html = File.read('./fixtures/IMDb_top_250.html')
    index = Nokogiri::HTML(html)

    movie_list_array = index.css("tbody.lister-list tr").collect do |movie|
      #movie title: movie.css("td.titleColumn a").text
      #movie year: movie.css("td.titleColumn span.secondaryInfo").text
      #movie url: movie.css("td.titleColumn a").attr("href").value
      {:title => movie.css("td.titleColumn a").text,
       :year => movie.css("td.titleColumn span.secondaryInfo").text,
       :url => movie.css("td.titleColumn a").attr("href").value
      }
    end
  end # scrape_top_list

  def self.scrape_movie_page()
    html = File.read('./fixtures/The Shawshank Redemption (1994) - IMDb.html')
    index = Nokogiri::HTML(html)
    binding.pry
    
  end #scrape_movie_page

end
