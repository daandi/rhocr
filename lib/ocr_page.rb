#coding: utf-8
require_relative "ocrx_word"
require 'nokogiri'
require 'pp'

class OCRPage < HOCRBox
    
    attr_accessor :meta_data, :page, :meta_data, :dimensions
    
    def initialize(filename)
       @page = {:blocks => []}
       @meta_data = Hash.new
       process_hocr_html_file(filename)
    end
    
    def process_hocr_html_file(filename)
        hocr_doc = Nokogiri::HTML(File.open(filename,"r"))
        hocr_doc.css('div.ocr_page').each do |page_html|
            page_html.css('div.ocrx_block').each do |block_html|
                
                current_block = { :paragraphs => [] }
                
                block_html.css('p.ocr_par').each do |paragraph_html|
                        current_paragraph = { :lines => []}
                        
                    paragraph_html.css('span.ocr_line').each do |line_html|
                            current_line = { :words => []}
                            
                        line_html.css('span.ocrx_word').each do |word_html|
                            current_line[:words] << OCRXWord.new(word_html.text, get_position(word_html))
                        end
                    end
                
                end 
            end
        end
    end
    
    
    def enclosed_words(box)
        words.select { |word| word.enclosed_by? box }
    end
        
    def get_position(element)
        bbox = element.at_xpath('//@title').text 
        bbox =~ /bbox (\d+) (\d+) (\d+) (\d+)/
        [$1,$2,$3,$4]
    end
    
    def page_dimensions_and_number( bbox )
        
    end
    
end
