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
      it 'should create an element from html input' do
          puts @ocr_element
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
  end
  
  describe '#specialities' do
      it 'should drop non-ocr-elements'
  end
  
  describe '#ocr_classes' do
      it 'ocr_elements of class ocr_box should have an alias for children called #paragraphs'
      
      it 'ocr_elements of class ocr_par should have an alias for children called #lines' do
          @ocr_element.respond_to?(:lines).should be_true
      end

      it 'ocr_elements of class ocr_line should have an alis for children called #words' do
        @ocr_element.lines[0].respond_to?(:words).should be_true
      end
      
      it 'ocr_elements of class ocr_word should not have children' 
  end
  
  describe 'html_methods' do
      it 'should have a #to_html method' do
        @ocr_element.to_html.should == "<span style='position:absolute; top:109px; left:79px; height:80px; width:1040px;' class='ocr_par'></span>"
      end
  end
  
 end