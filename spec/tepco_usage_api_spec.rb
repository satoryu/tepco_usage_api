require File.expand_path(File.join(
          File.dirname(__FILE__), 'spec_helper'))

describe TepcoUsage do
  describe "#latest" do
    before do
      TepcoUsage.stub!(:request).with('/latest.json').and_return do
        <<-JSON
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
    
  end
end
