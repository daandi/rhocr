#coding: utf-8

require_relative '../lib/ocr_box'

describe OCRBox do
    
    before(:each) do
        @box ||=  OCRBox.new(1,2,20,8)
    end
    
    describe "#to_s" do
        it "prints a human readable Box-Version with coordinates upper_left(x,y) bottom_right(x,y)" do
            @box.to_s.should == "tl->(x:1 y:2)/br->:(x:20 y:8)"
        end
    end
    
    describe '#encloses?(element)' do
        it "tests wather given OCRBox is enclosed by the current OCRBox" do
            @box.encloses?( OCRBox.new(0,3,19,7) ).should be_false
            @box.encloses?( OCRBox.new(2,3,19,7) ).should be_true
        end
        it "encloses also itself" do
            @box.encloses?( @box ).should be_true
        end
    end
    
    describe '#to_css_style' do
        it 'should create css-style attributes' do
            @box.to_css_style.should == 'position:absolute; top:2px; left:1px; height:6px; width:19px;'
        end
    end
    
    describe '#enclosed_by?(element)' do
        it 'should be enclosed by Boxes bigger than itself' do
            @box.enclosed_by?( OCRBox.new(0,1,21,9) ).should be_true
        end
        it 'should not be enclosed by Boxes smaller than itself' do
            @box.enclosed_by?( OCRBox.new(2,3,19,7) ).should be_false
        end
        it 'should be enclosed by Boxes of the same size' do
            @box.enclosed_by?( @box ).should be_true
        end
    end
    

    
    
end