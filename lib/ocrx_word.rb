#coding: utf-8

require 'cgi'
require_relative 'hocr_element'

class OCRXWord < HOCRElement
    
    attr_reader :text
    
    def initialize(html_fragment)
        super(html_fragment)
    end
    
    def initialize(word, *coordinates)
        super super(coordinates)
        @text = word
    end
    
    def to_html(css_class = 'ocrx_word')
        "<span style='#{ to_css_style }' class='#{css_class}'><span class='word'>" + CGI::escapeHTML(@text) +"</span></span>"
    end
    
    def to_s
        "#{@text}:\t#{super}"
    end

end