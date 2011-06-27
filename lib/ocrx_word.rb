#coding: utf-8

require 'cgi'
require_relative 'ocr_box'

class OCRXWord
    
    include OCRBox
    
    attr_reader :text,  :x1, :y1, :x2, :y2
    
    def initialize(x1,y1,x2,y2,word)        
        super(x1.to_i, y1.to_i, x2.to_i, y2.to_i)
        @text = word
    end
    
    def to_html(css_class)
        "<span style='#{ to_css_style }' class='#{css_class}'><span class='word'>" + CGI::escapeHTML(@text) +"</span></span>\n"
    end
    
    def to_s
        "#{@text}" + super()
    end

end

__END__
test = OCRXWord.new("10","5","15","7","test")
p test
p test.to_html "ATEST"