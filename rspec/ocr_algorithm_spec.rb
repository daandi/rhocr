#coding: utf-8

require_relative '../lib/ocr_algorithm'
require_relative '../lib/ocr_page'
require 'pp'

describe OCRAlgorithm do
    
    before(:each) do
        @test_page ||= OCRPage.new 'data/bsb_test.html'
    end
    
    it 'should be implemented'
    
    describe 'Algorithms that work on line basis' do
    
        before(:each) do
            @test_lines = @test_page.lines[0..6]
        end
    
        it 'should create an array of word-distances per line' do
            for t in @test_lines do
                puts "#{t.simple_line} <br/>"
                p OCRAlgorithm.word_distances_for_line(t)
                puts "<br/>"
            end
            
            OCRAlgorithm.word_distances_for_line(@test_lines[0]).should == [18, 17, 325] 
            OCRAlgorithm.word_distances_for_line(@test_lines[1]).should == [40, 19, 18, 20, 20, 19, 20, 19]  
        end
        
        it 'should create a lsit of the biggest word distance per line #find_big_word_distance' do
            max =  OCRAlgorithm.find_big_word_distance(@test_page,3)
            pp max
        end
    
    end
    
end