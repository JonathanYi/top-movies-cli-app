require_relative '../config/environment.rb'

class Scraper

  def self.scrape_top_list(list_url)
    #for offline testing
    #html = File.read('./fixtures/IMDb_top_250.html')
    #link for where i got user-agent info
    #https://stackoverflow.com/questions/5798037/how-to-set-a-custom-user-agent-in-ruby
    html = open(list_url, 'User-Agent' => 'Ruby').read
    index = Nokogiri::HTML(html)

    movie_list_array = index.css("tbody.lister-list tr").collect do |movie| {
        :name => movie.css("td.titleColumn a").text,
        :year => movie.css("td.titleColumn span.secondaryInfo").text,
        :url => movie.css("td.titleColumn a").attr("href").value
      }
    end
    movie_list_array.take(1)
  end # scrape_top_list

  def self.scrape_movie_page(movie_url)
    #This is for offline testing
    #html = File.read('./fixtures/The Shawshank Redemption (1994) - IMDb.html')
    html = open(movie_url, 'User-Agent' => 'Ruby').read
    index = Nokogiri::HTML(html)

    movie_details = {}

    movie_details[:genre] = index.css("div[itemprop='genre'] a").collect {|genre| genre.text.strip}
    movie_details[:director] = index.css("span[itemprop='director'] a span").collect {|director| director.text.strip}
    movie_details[:release] ||= index.css("div#titleDetails h4")[3].next_sibling.text.strip
    movie_details[:storyline] = index.css("div[itemprop='description'] p").text.gsub(/\s+/, " ").strip
    movie_details[:review_rating] = index.css("span[itemprop='ratingValue']").text.strip
    movie_details[:runtime] = index.css("time[itemprop='duration']")[0].text.strip

    movie_details

  end #scrape_movie_page

end
