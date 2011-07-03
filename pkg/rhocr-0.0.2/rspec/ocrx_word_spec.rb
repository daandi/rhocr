#coding: utf-8

require_relative '../lib/ocrx_word'

describe OCRXWord do
  
  before(:each) do
      @ocrx_word = OCRXWord.new(10,15,20,20,'WORT')
  end
  
  describe '#to_s' do
      it 'should print the coordinates of the box and the textual information' do
        p @ocrx_word
        @ocrx_word.to_s.should == "WORT\ttl->(x:10 y:15)/br->:(x:20 y:20)"
      end
  end
  
  describe '#to_html(css_class)' do
      it 'should create an span elment to overlay an image on an html-page' do
        @ocrx_word.to_html.should == "<span style='position:absolute; top:15px; left:10px; height:5px; width:10px;' class='ocrx_word'><span class='word'>WORT</span></span>"
      end
      
      it 'no css_class_class given should default to ocrx_word' do
          @ocrx_word.to_html.should =~ /class='ocrx_word'/
      end
      
      it 'css_class given should be part of genearted html' do
          @ocrx_word.to_html('rosebud').should =~ /class='rosebud'/
      end
  end
  
end
