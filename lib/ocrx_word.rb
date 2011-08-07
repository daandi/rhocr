#coding: utf-8

require 'cgi'
require_relative 'hocr_box'

class OCRXWord < HOCRBox
    
    attr_reader :text
    
    def initialize(word, *coordinates)
        super(coordinates)
        @text = word
    end
    
    def to_html(css_class = 'ocrx_word')
        "<span style='#{ to_css_style }' class='#{css_class}'><span class='word'>" + CGI::escapeHTML(@text) +"</span></span>"
    end
    
    def to_s
        "#{@text}:\t#{super}"
    end

end