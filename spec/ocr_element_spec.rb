#coding: utf-8

require_relative '../lib/ocr_element'
require 'nokogiri'

require 'pp'
describe OCRElement do
  
  before(:each) do
      html_string = "<p class='ocr_par' title='bbox 79 109 1119 189' style='font-size:8pt;font-family:Arial;font-style:normal'><span class='ocr_line' title='bbox 79 109 1119 145'><span class='ocrx_word' title='bbox 79 109 294 144'>Athenobius,</span> <span class='ocrx_word' title='bbox 334 112 398 139'>Der</span> <span class='ocrx_word' title='bbox 417 115 476 139'>von</span> <span class='ocrx_word' title='bbox 494 112 545 139'>der</span> <span class='ocrx_word' title='bbox 565 112 687 140'>Göttin</span> <span class='ocrx_word' title='bbox 707 112 857 140'>Minerva</span> <span class='ocrx_word' title='bbox 876 112 954 145'>lebt,</span> <span class='ocrx_word' title='bbox 974 112 1043 140'>oder:</span> <span class='ocrx_word' title='bbox 1062 112 1119 140'>Mi»</span><br></span><span class='ocr_line' title='bbox 108 155 300 189'><span class='ocrx_word' title='bbox 108 159 183 182'>nerva</span> <span class='ocrx_word' title='bbox 201 155 300 189'>Bogen.</span></span></p>"
      
      @html_fragment = Nokogiri::HTML::fragment(html_string).child
      @ocr_element = OCRElement.create(@html_fragment)
  end
  
  describe '#initialize and Object' do
      it 'should create an element given ocr_class, children and coordiantes' do
          test_element = OCRElement.new('test', [], %w{10, 11, 20, 21})
          test_element.children.should == []
          test_element.coordinates.should == [10,11,20,21]
          test_element.ocr_class.should == 'test'
      end
      
      it 'should create an element from html input' do
          @ocr_element.should_not == nil
      end
      it 'should have an ocr_class' do
           @ocr_element.ocr_class.should == 'ocr_par'
      end
      it 'should have coordinates' do
           @ocr_element.coordinates.should == [79, 109, 1119, 189]
      end
      it 'should have children' do
           @ocr_element.children.length == 2
      end
      it 'should have features' do
          @ocr_element.respond_to?(:features).should be_true
      end
      it 'should have empty features on construction' do
        @ocr_element.features.should == []
      end
  end
  
  describe '#ocr_classes' do
      it 'ocr_elements of class ocr_block should have an alias for children called #paragraphs' do
        OCRBlock.new('test', [], %w{10, 11, 20, 21}).respond_to?(:paragraphs).should be_true
      end
      
      it 'ocr_elements of class ocr_par should have an alias for children called #lines' do
          @ocr_element.respond_to?(:lines).should be_true
      end

      it 'ocr_elements of class ocr_line should have an alis for children called #words' do
        @ocr_element.lines[0].respond_to?(:words).should be_true
      end
  end
  
  
  describe 'html_methods' do
      it 'should have a #to_image_html method' do
        @ocr_element.to_image_html.should == "<span class='ocr_par' style='position:absolute; top:109px; left:79px; height:80px; width:1040px;' ></span><span class='ocr_line' style='position:absolute; top:109px; left:79px; height:36px; width:1040px;' ></span><span class='ocrx_word' style='position:absolute; top:109px; left:79px; height:35px; width:215px;'>Athenobius,</span><span class='ocrx_word' style='position:absolute; top:112px; left:334px; height:27px; width:64px;'>Der</span><span class='ocrx_word' style='position:absolute; top:115px; left:417px; height:24px; width:59px;'>von</span><span class='ocrx_word' style='position:absolute; top:112px; left:494px; height:27px; width:51px;'>der</span><span class='ocrx_word' style='position:absolute; top:112px; left:565px; height:28px; width:122px;'>Göttin</span><span class='ocrx_word' style='position:absolute; top:112px; left:707px; height:28px; width:150px;'>Minerva</span><span class='ocrx_word' style='position:absolute; top:112px; left:876px; height:33px; width:78px;'>lebt,</span><span class='ocrx_word' style='position:absolute; top:112px; left:974px; height:28px; width:69px;'>oder:</span><span class='ocrx_word' style='position:absolute; top:112px; left:1062px; height:28px; width:57px;'>Mi»</span><span class='ocr_line' style='position:absolute; top:155px; left:108px; height:34px; width:192px;' ></span><span class='ocrx_word' style='position:absolute; top:159px; left:108px; height:23px; width:75px;'>nerva</span><span class='ocrx_word' style='position:absolute; top:155px; left:201px; height:34px; width:99px;'>Bogen.</span>"
      end
      it 'should have a #to_html method' do
        @ocr_element.to_html.should == "<span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>Athenobius,</span><span class='ocrx_word'>Der</span><span class='ocrx_word'>von</span><span class='ocrx_word'>der</span><span class='ocrx_word'>Göttin</span><span class='ocrx_word'>Minerva</span><span class='ocrx_word'>lebt,</span><span class='ocrx_word'>oder:</span><span class='ocrx_word'>Mi»</span> </span><span class='ocr_line'> <span class='ocrx_word'>nerva</span><span class='ocrx_word'>Bogen.</span> </span> </span>"
      end
  end
  
  describe 'ocr_line' do
    it 'should have a #to_text method' do
         @ocr_element.lines[0].to_text.should == "Athenobius, Der von der Göttin Minerva lebt, oder: Mi»"
    end
  end
  
  describe 'ocr_word' do
      it 'ocr_elements of class ocr_word should have a #text method' do
         @ocr_element.lines[0].words[5].text.should == "Minerva"
      end
      it 'special #to_image_html method' do
         @ocr_element.lines[0].words[5].to_image_html.should == "<span class='ocrx_word' style='position:absolute; top:112px; left:707px; height:28px; width:150px;'>Minerva</span>"
      end
      it 'special #to_html method' do
         @ocr_element.lines[0].words[5].to_html.should == "<span class='ocrx_word'>Minerva</span>"
      end
      it 'special #to_s method' do
         @ocr_element.lines[0].words[5].to_s.should == "Minerva:[707, 112, 857, 140]->[]"
         @ocr_element.lines[0].words[5].features << :a_test << :additional
         @ocr_element.lines[0].words[5].to_s.should == "Minerva:[707, 112, 857, 140]->[:a_test, :additional]"
      end
  end
  
 end