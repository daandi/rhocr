#coding: utf-8
require_relative '../lib/ocr_page'
require 'nokogiri'
require 'pp'

describe OCRPage do
  
  before(:each) do
      @test_page ||= OCRPage.new('data/bsb_test.html')
  end
  
  describe '#constructor and mehtods for construction' do
    it 'should work' do
        p @test_page.public_methods.sort
    end
    
    it 'should have an extractor method for page dimensions and page number' do
        dimensions, page_number = @test_page.extract_page_dimensions_and_number "bbox 0 0 1326 1326;ppageno 33"
        page_number.should == "33"
        dimensions.should == %w{ 0 0 1326 1326}
    end
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
