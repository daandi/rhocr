#coding: utf-8
require_relative "ocr_element"
require 'nokogiri'
require 'pp'

class OCRPage < OCRElement
    
    attr_accessor :meta_data, :page_number, :dimensions, :lines
    alias :each_block :each
    alias :blocks :children
    
    def initialize(filename)
        doc = process_hocr_html_file(filename)
        page_content = doc.at_css("div.ocr_page")
        coordinates, @page_number = extract_bbox_ppageno( page_content['title'] )
        
        @page_content  = doc.at_css("div.ocr_page")
        children = OCRElement.extract_children(@page_content)
        super('ocr_page', children, coordinates)
        
    end
    
    
    def each_paragraph
        for block in blocks do
            for paragraph in block do
                yield paragraph
            end
        end
    end
    
    def each_line
        for block in blocks do
            for paragraph in block do
                for line in  paragraph do
                    yield line
                end
            end
        end
    end
    
    def each_word
        for block in blocks do
            for paragraph in block do
                for line in  paragraph do
                    for word in line do
                        yield word
                    end
                end
            end
        end
    end
    
    def lines
        unless @lines then
            @lines = []
            
            each_line do |line|
                @lines << line
            end
            
        end
        @lines
    end
    
    def extract_bbox_ppageno( ocr_html_text_fragment )
        bbox, ppageno = ocr_html_text_fragment.split(';')
        ppageno =~ /(\d+)/
        [ extract_coordinates_from_string(bbox) , $1.to_i ]
    end
    
    def process_hocr_html_file(filename)
        html_string = File.open(filename,"r").read
        Nokogiri::HTML(html_string).elements
    end
    
    
    def enclosed_words(box)
    end
    
end
