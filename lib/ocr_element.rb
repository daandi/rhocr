#coding:utf-8

require_relative 'hocr_box'

class OCRElement < HOCRBox
    
    include Enumerable
    
    attr_reader :ocr_class, :children
    
    def self.create_from_html(ocr_element_html)
        case ocr_element_html['class']
        when 'ocrx_block' then
            OCRBox.new(ocr_element_html)
        when 'ocr_par' then
            OCRParagraph.new(ocr_element_html)
        when 'ocr_line' then
            OCRLine.new(ocr_element_html)
        when 'ocrx_word' then
            OCRWord.new(ocr_element_html)
        else
            OCRElement.new(ocr_element_html)
        end
    end
    
    def self.create(ocr_element_html)
        create_from_html(ocr_element_html)
    end
    
    def to_s
        "#{self.class}:#{super}->\n" + children.map { |c| "\t#{c.to_s}" }.join("\n")
    end
    
    def extract_coordinates(ocr_element_html)
        extract_coordinates_from_string ocr_element_html['title']
    end
    
    def extract_coordinates_from_string(s)
        s =~ /bbox (\d+) (\d+) (\d+) (\d+)/
        [$1, $2, $3, $4]
    end
    
    def extract_ocr_class(ocr_element_html)
        ocr_element_html['class']
    end
    
    def extract_children(ocr_element_html)
        children = []
        for child_fragment_html in ocr_element_html.children do
            children << OCRElement.create(child_fragment_html)
        end
        # br Elemente ausfiltern
        children.reject { |child| child.ocr_class == nil}
    end
    
    def extract_word_children(ocr_element_html)
        [ocr_element_html.text]
    end
    
    def each
        children.each do |child|
            yield child
        end
    end
    
    def to_html
        super @ocr_class
    end
    
    protected
    def initialize(ocr_element_html)
        @ocr_class = extract_ocr_class(ocr_element_html)
        @children = 
            if (@ocr_class != 'ocrx_word') then
                extract_children(ocr_element_html)
            else
               extract_word_children ocr_element_html
            end
            
            super( extract_coordinates(ocr_element_html) )
    end
    
end

class OCRWord < OCRElement
    alias :text :children
end

class OCRLine < OCRElement
    alias :words :children
end

class OCRParagraph < OCRElement
    alias :lines :children
end
class OCRBlock < OCRElement
    alias :paragraphs :children
end

