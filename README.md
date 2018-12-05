# top-movies-cli-app
Scrape project using imdb top 250 list with option to view further details on movies.
Menu provides option to view movies by Genre, or Director as well.

## Installation
Clone repository to your local machine.

## Usage/Development
Run ```bundle install``` to make sure you have the appropriate gems installed.

Scarper scrapes the entire 250 movies list from IMDb, but in #scrape_top_list you can set the nummer of movies to pass onto the Movies class, by changing the parameter for take.

```movie_list_array.take(5)```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/JonathanYi/top-movies-cli-app. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org/) code of conduct.

## License

The application is available as open source under the terms of the MIT License.
