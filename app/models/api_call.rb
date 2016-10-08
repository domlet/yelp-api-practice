# Based on a gist from Miles: 
# https://gist.github.com/milesgrimshaw/cf6a595c6fb1ab367862

class ApiCall
  def init
    consumer_key = ENV['CONSUMER_KEY']
    consumer_secret = ENV['CONSUMER_SECRET']
    token = ENV['TOKEN']
    token_secret = ENV['TOKEN_SECRET']
    api_host = 'api.yelp.com'

    # Seems to be a model from the API
    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
    access_token = OAuth::AccessToken.new(consumer, token, token_secret)

    path = "/v2/search?term=paleo&location=oakland"
    # path = "/v2/search?term=#{item}&location=#{city}"

    result = JSON.parse(access_token.get(path).body)
  end
end