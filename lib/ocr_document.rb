#coding: utf-8

require_relative 'ocr_page'

class OCRDocument
    attr_reader :pages, :page_count
    
    def initialize
        @pages = Hash.new()
        @page_count = 0
    end
    
    def add_pages( list_o_pages  )
        raise "no files given" if list_o_pages.empty?
        list_o_pages.each do |file|
            add_page(file)
        end
    end
    
    def add_page( file )
        page = OCRPage.new( file )
        @pages[page.page_number] = page
        @page_count += 1
    end
    
    def add_image_to_page(page_number, image_path)
        @pages[page_number].image = image_path
    end
    
    def page( number )
        @pages[number]
    end
    
    def each_page
        sorted_pages = @pages.keys.sort
        sorted_pages.each do |page_key|
            yield @pages[page_key]
        end
    end
    
    def each_line
        for page in @pages.values do
            page.each_line do |line|
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
    
    
    alias :add_files :add_pages
    alias :add_file :add_page
end