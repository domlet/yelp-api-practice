require 'oauth'
require 'json'
require 'pp'
require 'csv'
require 'erb'
require 'dotenv'
Dotenv.load

class ResultsController < ApplicationController
	def index
		
		@api_calls = ApiCall.new
    p '#' * 100
		results = @api_calls.init
		results['businesses'].each do |business| 
			pp business['name'] 
			pp business['location']['city']
			pp business['location']['city']
		end
		cities = []

		segments = [
			"fitness+class", "bootcamp", "crossfit+gym", "yoga+class", "pilates+class", "martial+arts+class", "spin+class", 
			"biking+class", "boxing", "ballet+class", "barre+class"
		]

		@result = Result.new({city: "oakland", item: "yoga", count: @ccount})
		@result.save
		@result_count = @result.count
		# @result_json = Result.test_var
	end
end