require 'oauth'
require 'json'
require 'pp'
require 'csv'
require 'dotenv'
Dotenv.load

consumer_key = ENV['CONSUMER_KEY']
consumer_secret = ENV['CONSUMER_SECRET']
token = ENV['TOKEN']
token_secret = ENV['TOKEN_SECRET']

api_host = 'api.yelp.com'

consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
access_token = OAuth::AccessToken.new(consumer, token, token_secret)


p consumer
p access_token

# cities = [
# "New+York", "Los+Angeles", "Chicago", "Houston", "Philadelphia", "Pheonix", "San+Antonio", "San+Diego", "Dallas", "San+Jose", "Austin", "Jacksonville",
# "Indianapolis", "San+Francisco", "Columbus", "Fort+Worth", "Charlotte", "Detroit", "El+Paso", "Memphis", "Boston", "Seattle", "Denver", "Washington",
# "Nashville", "Baltimore", "Louisville", "Portland", "Oklahoma+City", "Milwaukee", "Las+Vegas", "Albuquerque", "Tucson", "Fresno", "Sacramento", 
# "Long+Beach", "Kansas+City", "Mesa", "Virginia+Beach", "Atlanta","Colorado+Springs", "Raleigh", "Omaha", "Miami", "Oakland", "Tulsa", "Minneapolis", 
# "Cleveland", "Wichita", "Arlington", "New+Orleans", "Bakersfield", "Tampa", "Honolulu", "Anaheim", "Aurora", "Santa+Ana", "St.+Louis,MA", "Riverside", 
# "Corpus+Christi", "Pittsburgh"
# ]
cities = ['oakland']

segments = [
"fitness+class", "bootcamp", "crossfit+gym", "yoga+class", "pilates+class", "martial+arts+class", "spin+class", 
"biking+class", "boxing", "ballet+class", "barre+class"
]


CSV.open("yelp.csv", "wb") do |csv|
  row = Array.new
  row << "City"
  for y in 0..(segments.length-1)
    row << segments[y]
  end
  csv << row

  for z in 0..(cities.length-1)

    city = cities[z]
    row = Array.new
    row << city
    pp city

    for i in 0..(segments.length-1)

      item = segments[i]
      path = "/v2/search?term=#{item}&location=#{city}"

      result = JSON.parse(access_token.get(path).body)
      count = result["total"]

      p result

      pp count
      row << count
    end

    csv << row
  end
end
