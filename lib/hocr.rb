#coding: utf-8
require_relative "ocrx_word"

class HOCR
    attr_reader :lines,:words,:hocr
    
    def initialize(filename)
        hocr_contents = File.open(filename,"r") { |f| f.read }
        @lines =  hocr_lines( hocr_contents).select {|line| line.length > 0}
    end
    
    def hocr_lines( hocr_contents)
        hocr_array = []
        for line in  hocr_contents.split(/<span class="ocr_line"/) do
            line_array = []
            for ocrx_word in line.scan(/<span class="ocrx_word"[^>]+>[^<]+<\/span>/) do
                ocrx_word =~ /title="bbox (\d+) (\d+) (\d+) (\d+)">([^<]+)</
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
        words.collect {|word| box.encloses(word) }
    end
    
    def encloses?()
        
    end
    
    def get_position(element)
        element =~ /title="bbox (\d+) (\d+) (\d+) (\d+)">/
        [$1,$2,$3,$4]
    end
    
end
