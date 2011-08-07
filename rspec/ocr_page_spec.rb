#coding: utf-8
require_relative '../lib/ocr_page'
require 'nokogiri'

describe OCRPage do
  
  before(:each) do
      @hocr_page ||= OCRPage.new('data/bsb_test.html')
      @fragment = Nokogiri::HTML("<span class='ocr_line' title='bbox 432 32 1117 71'><span class='ocrx_word' title='bbox 432 32 588 67'>Athenobius</span> <span class='ocrx_word' title='bbox 606 48 640 54'>—</span> <span class='ocrx_word' title='bbox 657 34 749 62'>Aulon.</span> <span class='ocrx_word' title='bbox 1074 37 1117 71'>29</span></span>")
  end
  
  describe '#get_position' do
    it 'should extract the bounding box xoordinates' do
        @hocr_page.get_position(@fragment).should == ["432", "32", "1117", "71"]
    end
  end
  
  
  describe 'HOCRPage' do
      it 'should have data' do
        @hocr_page.page.should be_true
      end
      
      it 'should have metedata' do
      end
      it 'should have blocks' do
      end
      it 'should have paragraphs' do
      end
      it 'should have lines' do
          p @hocr_page.lines
      end
      it 'should have words' do
      end
  end
  
end

# Test
