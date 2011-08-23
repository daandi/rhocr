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
        @test_page.should_not be_nil
    end
    
    it 'should have an extractor method for page dimensions and page number' do
        dimensions, page_number = @test_page.extract_bbox_ppageno "bbox 0 0 1326 1326;ppageno 33"
        page_number.should == 33
        dimensions.should == %w{ 0 0 1326 1326}
    end
  end
  
  describe 'Page' do
      it 'should have a #page_number' do
          @test_page.page_number.should_not be_nil
          @test_page.page_number.should == 33
      end
      
      it 'should have metedata'
      
      it 'page should have #coordinates' do
          @test_page.coordinates.should == [0,0,1326,1326]
      end
      it 'should have children' do
        @test_page.children.should_not == []
      end
  end
  
  
  describe '#Iterators' do
      it 'should have a block iterator #each_block' do
          a = []
          @test_page.each_block do |block|
             a << block
          end
          a.length.should == 1
      end
      it 'should have a paragraph iterator #each_paragraph' do
          a = []
          @test_page.each_paragraph do |paragraph|
              a << paragraph
          end
          a.length.should == 28
      end
      it 'should have a line iterator #each_line' do
          a = []
          @test_page.each_line do |line|
                a << line
            end
          a.length.should == 43
      end
      it 'should have a word iterator #each_word' do
        a = []
        @test_page.each_word do |word|
            a << word
        end
        a.length.should == 346
      end
    
  end

end