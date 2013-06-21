require 'spec_helper'

describe "AdSense" do
   subject { AdSense }

   describe "default configuration" do
     specify { subject.default_ad_format.should eql AdSense::AdFormat::LeaderBoard }
     specify { subject.default_ad_type.should eql AdSense::AdType::TextImage }
   end
   
   describe "#ad_slot" do
   end
end
