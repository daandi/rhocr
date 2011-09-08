#coding: utf-8

require_relative "ocr_document"
class RHOCR < OCRDocument
    
    attr_reader :words, :lines
    
    def add_folder(path)
        add_files Dir[path]
        compute_lines
        compute_words
        self
    end
    
    #should be called if new pages are added
    def compute_words
        @words = []
        each_word do |w|
            @words << w
        end
    end
    
    #should be called if new pages are added
    def compute_lines
        @lines = []
        each_line do |l|
            @lines << l
        end
    end
    
end