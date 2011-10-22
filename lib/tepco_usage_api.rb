require 'net/http'
require 'json'

class TepcoUsage
  @@default_options = {
    :proxy => nil
  }

  def initialize(options = {})
    @options = @@default_options.merge(options.inject({}) do |opts, (key, value)|
      opts[key.to_sym] = value
      opts
    end)
  end

  def latest
    response = request('/latest.json')
    JSON.parse(response.body)
  end

  def at(arg)
    path = case arg
           when Date
             "/#{arg.year}/#{arg.month}/#{arg.day}.json"
           when Time
             "/#{arg.year}/#{arg.month}/#{arg.day}/#{arg.hour}.json"
           end
    response = request(path)
    JSON.parse(response.body)
  end

  def in(arg)
    path = "/#{arg.year}/#{arg.month}.json"
    response = request(path)
    JSON.parse(response.body)
  end

  private

  def create_http
    host = 'tepco-usage-api.appspot.com'
    if @options[:proxy].nil?
      return Net::HTTP.new(host)
    end

    proxy = @options[:proxy]
    proxy_uri = proxy.is_a?(URI) ? proxy : URI.parse(proxy)
    Net::HTTP.Proxy(proxy_uri.host, proxy_uri.port, proxy_uri.user, proxy_uri.password).new(host)
  end

  def http
    @http ||= create_http
  end

  def request(path)
    http.request_get(path)
  end

  class << self
    def latest
      tepco.latest
    end

    def at(arg)
      tepco.at(arg)
    end

    def in(arg)
      tepco.in(arg)
    end

    private

    def tepco
      unless @tepco
        @tepco = TepcoUsage.new
      end
      @tepco
    end
  end
end
