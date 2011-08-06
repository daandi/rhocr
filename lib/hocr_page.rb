#coding: utf-8
require_relative "ocrx_word"
require 'nokogiri'
require 'pp'

class HOCRPage < HOCRBox
    attr_reader :lines, :words, :meta_data
    
    def initialize(filename)
       meta_data = Hash.new
       read_local_html_file(filename)
    end
    
    def hocr_lines( hocr_contents)
        hocr_array = []
        for line in  hocr_contents.split(/<span class=['"]ocr_line['"]/) do
            line_array = []
            for ocrx_word in line.scan(/<span class=['"]ocrx_word['"][^>]+>[^<]+<\/span>/) do
                ocrx_word =~ /title=['"]bbox (\d+) (\d+) (\d+) (\d+)['"]>([^<]+)</
                current_word = OCRXWord.new($1,$2,$3,$4,$5)
                line_array << current_word
            end
             hocr_array << line_array
        end            
         hocr_array
    end
    
    def words
        @words ||= @lines.flatten
    end
    
    def enclosed_words(box)
        words.select { |word| word.enclosed_by? box }
    end
        
    def get_position(element)
        element =~ /title="bbox (\d+) (\d+) (\d+) (\d+)">/
        [$1,$2,$3,$4]
    end
    
    def read_local_html_file(filename)
        doc = Nokogiri::HTML(File.open(filename,"r"))
        read_meta_data(doc)
    end
    
    def read_meta_data(doc)
        for md in doc.css('meta') do 
            key = md.attribute('name')
            value = md.attribute('content')
            
            pp [key,value]
        end
    end
    
    
end
