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
    def OCRAlgorithm.find_word_distance_clusters(ocr_page, expected_clusters)
        max_distances = []
        
        ocr_page.lines.each do |line|
            max_distances << OCRAlgorithm.word_distances_for_line(line).max
        end
        
        calculate_distance_clusters(max_distances, expected_clusters)
    end
    
    
    def OCRAlgorithm.calculate_distance_clusters(data, expected_clusters)
        data = data.reject{ |d| d.nil?}.collect { |d| [d,d]}
  
        ai4r_data = Ai4r::Data::DataSet.new(:data_items=> data)
        b = Ai4r::Clusterers::KMeans.new
        b.build(ai4r_data, expected_clusters)
    end
    
    def OCRAlgorithm.extract_cluster_lower_bounds(cluster_object)
       lb = cluster_object.clusters.collect {|cluster| cluster.data_items.flatten.uniq.min}
       lb.sort
    end
    
    # Add feature for all words before a special lower bound,
    # Example:
    # Lemma_1 ... Lemmma_N | distance| Description
    def OCRAlgorithm.add_word_features_based_on_distances_to_line(line, distance, feature)
        distance_found_index = OCRAlgorithm.find_distance_position_in_line(line, distance)
        line.each_with_index do |word,index|
            if distance_found_index and index <= distance_found_index then
                word.features << feature
            else
                break
            end
        end
    end
    
    def OCRAlgorithm.add_word_features_based_on_distance_to_page(page, distance, feature)
        for line in page.lines do
            OCRAlgorithm.add_word_features_based_on_distances_to_line(line, distance, feature)
        end
    end
    
    def OCRAlgorithm.find_distance_position_in_line(line, distance)
        line.each_with_index  do |word,index|
            if line.children[ index+1 ] then
                next_word = line.children[ index+1 ]
                if word.right_distance_to(next_word) >= distance then
                    return index
                end
            end
        end
        # If nothing is found return false
        false
    end
    
    
end