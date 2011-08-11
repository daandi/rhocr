#coding:utf-8

require_relative 'hocr_box'


class OCRElement < HOCRBox
    
    include Enumerable
    
    attr_reader :ocr_class, :children
    
    def initialize(ocr_element_html)
        
        super( extract_coordinates(ocr_element_html) )
        @ocr_class = extract_ocr_class(ocr_element_html)
        @children = 
            if (@ocr_class != 'ocrx_word') then
                extract_children(ocr_element_html)
            else
                extract_word_children(ocr_element_html)
            end
    end
    
    def to_s
        "#{@ocr_class}:#{super} -> #{ @children.collect { |c| c.to_s} }"
    end
    
    def extract_coordinates(ocr_element_html)
        pos = ocr_element_html['title']
        pos =~ /bbox (\d+) (\d+) (\d+) (\d+)/
        [$1, $2, $3, $4]
    end
    
    def extract_ocr_class(ocr_element_html)
        ocr_element_html['class']
    end
    
    def extract_children(ocr_element_html)
        children = []
        for child_fragment_html in ocr_element_html.children do
            children << OCRElement.new(child_fragment_html)
        end
        children
    end
    
    def extract_word_children(ocr_element_html)
        [ocr_element_html.text]
    end
    
    def each
        children.each do |child|
            yield child
        end
    end
    
end