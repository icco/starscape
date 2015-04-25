require "rubygems"
require "bundler"
Bundler.require(:default, ENV["RACK_ENV"] || :development)

require "csv"
require "json"

get "/stars.json" do
  @consts = {}
  CSV.open("stars.csv", :headers => true).each do |s|
    @consts[s["constellation_name"]] ||= []
    @consts[s["constellation_name"]].push({
      x: s["X"].to_f,
      y: s["Y"].to_f,
      lum: s["Luminosity"].to_f
    })
  end

  content_type :json
  @consts.to_json
end

get "/" do
  erb :index
end
