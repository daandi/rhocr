#coding: utf-8

require 'cgi'
require_relative 'ocr_box'

class OCRXWord < OCRBox
    
    attr_reader :text
    
    def initialize(x1,y1,x2,y2,word)        
        super(x1.to_i, y1.to_i, x2.to_i, y2.to_i)
        @text = word
    end
    
    def to_html(css_class = 'ocrx_word')
        "<span style='#{ to_css_style }' class='#{css_class}'><span class='word'>" + CGI::escapeHTML(@text) +"</span></span>"
    end
    
    def to_s
        "#{@text}\t#{super}"
    end

end