require_relative "../scraper"

# data for #fetch_movies_url:
# [
#   "http://www.imdb.com/title/tt0111161/",
#   "http://www.imdb.com/title/tt0068646/",
#   "http://www.imdb.com/title/tt0071562/",
#   "http://www.imdb.com/title/tt0468569/",
#   "http://www.imdb.com/title/tt0050083/"
# ]

describe "#fetch_movies_url" do
  it "expect to return an array of movies" do
    urls = fetch_movies_url
    expected = [
       "http://www.imdb.com/title/tt0111161/",
       "http://www.imdb.com/title/tt0068646/",
       "http://www.imdb.com/title/tt0071562/",
       "http://www.imdb.com/title/tt0468569/",
       "http://www.imdb.com/title/tt0050083/"
     ]
     expect(urls).to eq(expected) 
  end
  
end


# data for #scrape_movie:
# {
#   cast: [ "Christian Bale", "Heath Ledger", "Aaron Eckhart" ],
#   director: "Christopher Nolan",
#   storyline: "When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham. The Dark Knight must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
#   title: "The Dark Knight",
#   year: 2008
# }

describe "#scrape_movie" do
  it "expect to include The Dark Night Movie" do
    dark_night_url = 'https://www.imdb.com/title/tt0468569/'
    dark_night = scrape_movie(dark_night_url)
    expected = {
       cast: [ "Christian Bale", "Heath Ledger", "Aaron Eckhart" ],
       director: "Christopher Nolan",
       storyline: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
       title: "The Dark Knight",
       year: 2008
     }

     expect(dark_night).to eq(expected)
  end
end


describe "#write_yaml" do
  it "expect to save YAML file with movie" do
    movie  = {
      cast: [ "Christian Bale", "Heath Ledger", "Aaron Eckhart" ],
      director: "Christopher Nolan",
      storyline: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
      title: "The Dark Knight",
      year: 2008
    }
    write_yaml(movie)
    movie_file = YAML::load_file('movies.yml')

    expect(movie_file).to eq(movie)
  end
end