require 'net/http'
require 'json'

class TepcoUsage
  class << self
    def latest
      response = request('/latest.json')
      JSON.parse(response.body)
    end

    def at(date)
      path = "/#{date.year}/#{date.month}/#{date.day}.json"
      response = request(path)
      JSON.parse(response.body)
    end

    private
    def request(path)
      http.request_get(path) 
    end

    def http
      unless @http
        @http = Net::HTTP.new('tepco-usage-api.appspot.com')
      end
      @http
    end
  end
end
