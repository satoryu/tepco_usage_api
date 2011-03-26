require 'net/http'
require 'json'

class TepcoUsage
  class << self
    def latest
      response = request('/latest.json')
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
