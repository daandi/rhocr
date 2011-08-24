#coding: utf-8

require 'ai4r'

module OCRAlgorithm
    
    def OCRAlgorithm.word_distances_for_line(ocr_line)
        distances = []
        ocr_line.each_cons(2) do |w1,w2|
            distances << w1.right_distance_to(w2)
        end
        distances
    end
    
    
    #Idee: Wortabstände pro Zeile, daraus Maximum, das in zwei Gruppen clustern
    def OCRAlgorithm.find_big_word_distance(ocr_page, expected_clusters)
        max_distances = []
        
        ocr_page.lines.each do |line|
            max_distances << OCRAlgorithm.word_distances_for_line(line).max
        end
        
        data = max_distances.reject{ |d| d.nil?}.collect { |d| [d,d]}
  
        ai4r_data = Ai4r::Data::DataSet.new(:data_items=> data)
        b = Ai4r::Clusterers::KMeans.new
        b.build(ai4r_data, expected_clusters)
    end
    
end