#coding: utf-8
require_relative '../lib/ocr_page'
require 'nokogiri'
require 'pp'

describe OCRPage do
  
  before(:each) do
      @ocr_page = OCRPage.new('data/bsb_test.html')
  end
  
  describe '#extract_page_dimensions_and_number' do
    bbox, page_number = OCRPage.new('data/bsb_test.html').extract_page_dimensions_and_number('bbox 0 0 1326 1326;ppageno 33')
    bbox.should == '0 0 1326 1326'
    page_number.should == 36
  end
  
  describe 'Page' do
      it 'should have a page-number'
      it 'should have metedata'
      it 'page should have dimensions'
  end
  
  
  describe '#Iterators' do
      it 'should have a block iterator #each_block'
      it 'should have a paragraph iterator #each_paragraph'
      it 'should have a line iterator #each_line'
      it 'should have a word iterator #each_word'
    
  end
  
  
end

# Test
