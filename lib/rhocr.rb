#coding: utf-8

require_relative "ocr_document"
class RHOCR < OCRDocument
    
    def add_folder(path)
        add_files Dir[path]
    end
    
    def words
        Enumerator.new(self,:each_word)
    end
    
    def lines
        Enumerator.new(self,:each_line)
    end
    
end