require File.expand_path(File.join(
          File.dirname(__FILE__), 'spec_helper'))

describe TepcoUsage do
  describe "#latest" do
    subject{TepcoUsage}
    its(:latest) { should_not be_nil } 
  end
end
