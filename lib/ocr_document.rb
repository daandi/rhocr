#coding: utf-8

require_relative 'ocr_page'

class OCRDocument
    attr_reader :pages
    
    def initialize
        @pages = Hash.new()
    end
    
    def add_pages( list_o_pages  )
        for file in list_o_pages do
            add_page(file)
        end
    end
    
    def add_page( file )
        page = OCRPage.new( file )
        @pages[page.page_number] = page
    end
    
    def page( number )
        @pages[number]
    end
    
    def each_line
        for page in @pages.values do
            for line in page.lines do
                yield line
            end
        end
    end
    
    def each_word
        for page in @pages.values do
            page.each_line do |line|
                line.each do |word|
                    yield word
                end
            end
        end
    end
    
    
end