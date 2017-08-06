# Specifications for the CLI Assessment

Specs:
- [x] Have a CLI for interfacing with the application
    CLI.rb is a command line interface that calls Scraper methods and creates movie, genre and director objects. CLI calls instances of these objects to present options and data to the user.
- [x] Pull data from an external source
    Scraper.rb is scrapping data initially from http://www.imdb.com/chart/top.
    Once movie objects are created, additional scraping is done on each movie to get further details on each movie.
- [x] Implement both list and detail views
    The CLI provides option to list movies, then the user can get details on a particular movie.
    Additional options are available to display a list of genres, or directors. Selecting one of these will provide a list of movies according to the selection. Then the user can get further details on an individual movie. 
