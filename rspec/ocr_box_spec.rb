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
    
    describe '#right_of?(element)' do
        it 'should be right of any box-element that has a smaller x1 value than current x2 value' do
            @box.right_of?( OCRBox.new(0,2,0,8) ).should be_true #x1 == x2 -> Eine Linie
        end
        it 'should not be right of' do
            @box.right_of?( OCRBox.new(1,2,2,8) ).should be_false
        end
    end
    
    describe '#left_of?(element)' do
        it 'should be left of any box-element that has a larger x1 than the current box has x2' do
            @box.left_of?( OCRBox.new(21,2,21,8) ).should be_true #x1 == x2 -> Eine Linie
        end
        it 'should not be left of' do
            @box.left_of?( OCRBox.new(1,2,2,8) ).should be_false
        end
    end
    

    
    
end