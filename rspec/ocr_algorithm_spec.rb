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
            @test_lines = @test_page.lines[0..15]
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
        
        it 'should create a list of the biggest word distance per line #find_word_distance_clusters' do
            max =  OCRAlgorithm.find_word_distance_clusters(@test_page , 3)
        end
        
        it 'test #OCRAlgorithm.calculate_distance_clusters(data, expected_clusters)'
        
        it 'should extract the lower bounds of the clusters #OCRAlgorithm.extract_cluster_lower_bounds(cluster_object)' do
            
            OCRAlgorithm.extract_cluster_lower_bounds(  OCRAlgorithm.find_word_distance_clusters(@test_page , 3)).
            should == [18, 35, 325]
            
        end
        
        it 'should add features to OCRWords based on lower bound distances'
        
        it 'should find the index before the distance between two words in a line appears' do
            OCRAlgorithm.find_distance_position_in_line(@test_page.lines[3], 35).should == false
            OCRAlgorithm.find_distance_position_in_line(@test_page.lines[1], 35).should == 0
            OCRAlgorithm.find_distance_position_in_line(@test_page.lines[0], 35).should == 2
        end
        
        it 'should add features to OCRWords based on lower bound distances per line OCRAlgorithm.add_word_features_based_on_distances_to_line(line, distance, label)' do
            OCRAlgorithm.add_word_features_based_on_distances_to_line(@test_page.lines[1], 35, :before_distance)
            @test_page.lines[1].words[0].
                features.find(:before_distance).should be_true
            @test_page.lines[1].words[1].
                features.include?(:before_distance).should be_false  
        end
        
        it 'should add features based on distance to all line of a page' do
            OCRAlgorithm.add_word_features_based_on_distance_to_page(@test_page, 35, :test)
            
            @test_page.each_word do |word|
                if word.features.include?(:test) then
                   puts word.mark_in_rspec('red')
               else
                   puts word
               end
           end
            
        end
        
    end
    
end