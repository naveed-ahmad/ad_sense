require 'spec_helper'

describe "AdFormat" do
  subject { AdSense::AdFormat }
  formats_map = {
    large_leader_board: [970, 90],
    medium_rectangle:   [300, 250],
    large_skyscraper:   [300, 600],
    small_rrectangle:   [180, 150],
    large_rectangle:    [336, 280],
    vertical_banner:    [120, 240],
    wide_skyscraper:    [160, 600],
    vertical_banner:    [120, 240],
    mobile_banner:      [320, 50],
    leader_board:       [728, 90],
    small_square:       [200, 200],
    skyscraper:         [120, 600],
    half_banner:        [234, 60],
    banner:             [468, 60],
    square:             [250, 250],
    button:             [125, 125]
  }


  describe "#available_formats" do
    specify { subject.available_formats.size.should eql 15 }
    specify { subject.available_formats.should eql formats_map.keys }
  end
  
  describe "#get_dimension" do
    formats_map.keys.each do |format|
      it "return #{ formats_map[format] } for #{ format }" do
        subject.get_dimension(format).should eql formats_map[format]
      end
    end
  
    it "return [] for wrong format" do
      subject.get_dimension(:foo_bar).should eql []
    end
   
    it "return dimension if parameter is value of a format" do
      subject.get_dimension("1x2").should eql [1, 2]
    end
  end
end
