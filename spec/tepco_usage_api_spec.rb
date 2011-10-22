require File.expand_path(File.join(
          File.dirname(__FILE__), 'spec_helper'))
require 'date'

describe TepcoUsage do
  describe "#latest" do
    before do
      tepco = TepcoUsage.send(:tepco)
      tepco.stub!(:request).with('/latest.json').and_return do
        mock = mock(Object.new, :body => <<-JSON)
           {
             "saving": false,
             "hour": 0,
             "capacity_updated": "2011-03-26 09:30:00",
             "month": 3,
             "usage_updated": "2011-03-26 16:30:54",
             "entryfor": "2011-03-26 15:00:00",
             "capacity_peak_period": 18,
             "year": 2011,
             "usage": 2904,
             "capacity": 3700,
             "day": 27
           }
        JSON
      end
    end

    subject{TepcoUsage}
    its(:latest) { should_not be_nil }
    it do
      TepcoUsage.latest['saving'].should be_false
    end

  end
  describe "#at" do
    context "Given Date object" do
      before do
        today = Date.today
        path = "/#{today.year}/#{today.month}/#{today.day}.json"
        tepco = TepcoUsage.send(:tepco)
        tepco.stub!(:request).with(path).and_return do
          mock = mock(Object.new, :body => <<-JSON)
          [
            {
              "saving": false,
              "hour": 0,
              "capacity_updated": "2011-03-25 16:05:00",
              "month": 3,
              "usage_updated": "2011-03-25 16:30:49",
              "entryfor": "2011-03-25 15:00:00",
              "capacity_peak_period": null,
              "year": 2011,
              "usage": 2889,
              "capacity": 3750,
              "day": 26
            },
            {
              "saving": false,
              "hour": 1,
              "capacity_updated": "2011-03-25 16:05:00",
              "month": 3,
              "usage_updated": "2011-03-25 17:05:49",
              "entryfor": "2011-03-25 16:00:00",
              "capacity_peak_period": null,
              "year": 2011,
              "usage": 2758,
              "capacity": 3750,
              "day": 26
            }
          ]
          JSON
        end
      end
      subject{TepcoUsage.at(Date.today)}
      it { should_not be_nil }
    end

    context "Given Time object" do
      before do
        @now = Time.now
        path = "/#{@now.year}/#{@now.month}/#{@now.day}/#{@now.hour}.json"
        tepco = TepcoUsage.send(:tepco)
        tepco.stub!(:request).with(path).and_return do
          mock = mock(Object.new, :body => <<-JSON)
          [
            {
              "saving": false,
              "hour": 0,
              "capacity_updated": "2011-03-25 16:05:00",
              "month": 3,
              "usage_updated": "2011-03-25 16:30:49",
              "entryfor": "2011-03-25 15:00:00",
              "capacity_peak_period": null,
              "year": 2011,
              "usage": 2889,
              "capacity": 3750,
              "day": 26
            },
            {
              "saving": false,
              "hour": 1,
              "capacity_updated": "2011-03-25 16:05:00",
              "month": 3,
              "usage_updated": "2011-03-25 17:05:49",
              "entryfor": "2011-03-25 16:00:00",
              "capacity_peak_period": null,
              "year": 2011,
              "usage": 2758,
              "capacity": 3750,
              "day": 26
            }
          ]
          JSON
        end
      end
      subject{TepcoUsage.at(@now)}
      it { should_not be_nil }
    end
  end
  describe "#in" do
    before do
      @now = Time.now
      path = "/#{@now.year}/#{@now.month}.json"
      tepco = TepcoUsage.send(:tepco)
      tepco.stub!(:request).with(path).and_return do
        mock(Object.new, :body => '{"body": "dummy"}')
      end
    end

    subject{TepcoUsage.in @now}
    it { should_not be_nil }
  end

  context "Configuration" do
    describe "About Proxy" do
      before do
        host = 'proxy.example.com'
        port = 4567
        user = 'proxy_user'
        password = 'proxy_pass'
        @proxy = URI.parse("http://#{user}:#{password}@#{host}:#{port}")
        @tepco = TepcoUsage.new(:proxy => @proxy)
      end
      subject {@tepco.send :http_class}
      it { should be_proxy_class }
      its(:proxy_address) { should == @proxy.host }
      its(:proxy_port) { should == @proxy.port }
      its(:proxy_user) { should == @proxy.user }
      its(:proxy_pass) { should == @proxy.password }
    end
  end
end
