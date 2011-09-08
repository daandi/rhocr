#coding: utf-8

require_relative '../lib/ocr_document'

describe OCRDocument do
    
    it 'construcructor should create an empty document with page_count 0' do
        d = OCRDocument.new
        d.page_count.should == 0
    end
    
    it 'should be possible to add a file' do
        d = OCRDocument.new
        d.add_page 'data/bsb_test.html'
    end
    
    it 'adding a file should raise page_count' do
        d = OCRDocument.new
        old_page_count = d.page_count
        d.add_page 'data/bsb_test.html'
        
        d.page_count.should == old_page_count + 1
    end
    
    describe 'methods to #add_page an access pages' do
        
        before(:each) do
            @test_document = OCRDocument.new
            @test_document.add_page 'data/bsb_test.html'
            @test_document.add_page 'data/Seite_Tagebuch_H_C_Lang_08.html'
            @test_document.add_page 'data/test.html'
        end
        
        it 'should have #pages' do
            @test_document.pages.keys.sort.should == [20, 33, 105]
        end
        
        it 'should retrieve page by pagenumber' do
            page = @test_document.pages[33]
            page_words = []
            page.each_word do |word|
                page_words << word
            end
            page_words.length.should == 346
        end
        
        it 'should have an alternate syntax for accessing pages by #page' do
            @test_document.page(105).should == @test_document.pages[105]
        end
        
    end
    
    describe 'Methods to iterate over words and lines' do
        
        before(:each) do
            @test_document = OCRDocument.new
            @test_document.add_page 'data/bsb_test.html'
            @test_document.add_page 'data/Seite_Tagebuch_H_C_Lang_08.html'
            @test_document.add_page 'data/test.html'
        end
        
        it ' should have a method to iterate over document lines #each_line' do
            a = []
            @test_document.each_line do |line|
                a << line
            end
            a.size.should == 129
        end
        
        it ' should have a method to iterate over document words #each_word' do
            a = []
            @test_document.each_word do |word|
                a << word
            end
            a.size.should == 1120
        end
        
    end
    
    
    it 'should be able to use ocr_algorithms on pages'
    
  
end