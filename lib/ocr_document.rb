#coding: utf-8

require_relative 'ocr_page'

class OCRDocument
    attr_reader :pages
    
    def initialize
        @pages = Hash.new()
    end
    
    def add_page( file )
        page = OCRPage.new( file )
        @pages[page.page_number] = page
    end
    
    def page( number )
        @pages[number]
    end
    
    
end