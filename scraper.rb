require 'open-uri'
require 'pry'
require 'nokogiri'


def fetch_movies_url
  response = open('https://www.imdb.com/chart/top').read
  html_doc = Nokogiri::HTML(response)
  top_movie_tags = html_doc.search('.titleColumn a').first(5)
  top_movie_tags.map do |tag|
    "http://www.imdb.com#{tag.attribute('href').value}"
  end
end


def scrape_movie(url)
  response = open(url, "Accept-Language" => "en").read
  html_doc = Nokogiri::HTML(response)
  {
    cast: html_doc.search('.cast_list .primary_photo+td a').first(3).map {|tag| tag.text.strip},
    director: html_doc.search("h4:contains('Director:') + a").text,
    storyline: html_doc.search('.summary_text').text.strip,
    title: html_doc.search('h1').text.match(/(?<title>.*)[[:space:]]\((?<year>\d{4})\)/)[:title],
    year: html_doc.search('h1 #titleYear').text.match(/\d{4}/)[0].to_i
  }
end


def write_yaml(movies)
  File.open('movies.yml', 'wb+') do |f| 
    f.write(movies.to_yaml)
  end
end

def save_top_movies
  puts "Starting scraper"
  urls = fetch_movies_url
  movies = urls.map { |url| scrape_movie(url) }
  write_yaml({movies: movies})
  puts "Movies saved with success"
end

save_top_movies