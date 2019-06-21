require 'spec_helper'
require 'date'

describe TepcoUsage do
  describe "#latest" do
    before do
      tepco = TepcoUsage.send(:tepco)
      allow(tepco).to receive(:request).with('/latest.json').and_return(
        double('dummy response', :body => <<-JSON)
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
      )
    end

    it { expect(TepcoUsage.latest).to_not be_nil }
    it do
      expect(TepcoUsage.latest['saving']).to be_falsy
    end

  end
  describe "#at" do
    context "Given Date object" do
      before do
        today = Date.today
        path = "/#{today.year}/#{today.month}/#{today.day}.json"
        tepco = TepcoUsage.send(:tepco)
        allow(tepco).to receive(:request).with(path).and_return(
          double('dummy response', :body => <<-JSON)
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
        )
      end

      it { expect(TepcoUsage.at(Date.today)).to_not be_nil }
    end

    context "Given Time object" do
      before do
        @now = Time.now
        path = "/#{@now.year}/#{@now.month}/#{@now.day}/#{@now.hour}.json"
        tepco = TepcoUsage.send(:tepco)
        allow(tepco).to receive(:request).with(path).and_return(
          double('dummy response', :body => <<-JSON)
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
        )
      end

      it { expect(TepcoUsage.at(@now)).to_not be_nil }
    end
  end

  describe "#in" do
    before do
      @now = Time.now
      path = "/#{@now.year}/#{@now.month}.json"
      tepco = TepcoUsage.send(:tepco)
      expect(tepco).to receive(:request).with(path).and_return(
        double('dummy response', :body => '{"body": "dummy"}')
      )
    end

    subject{TepcoUsage.in @now}
    it { expect(TepcoUsage.in(@now)).to_not be_nil }
  end
end
