#coding: utf-8

class OCRBox
    
    attr_reader :x1, :y1, :x2, :y2
    
    def initialize(x1, y1 , x2, y2)
        @x1 = x1
        @y1 = y1
        @x2 = x2
        @y2 = y2
    end
    
    def encloses?(element)
        @x1 <= element.x1 and 
        @x2 >= element.x2 and
        @y1 <= element.y1 and 
        @y2 >= element.y2
    end
    
    def enclosed_by?(element)
        return element.encloses? self
    end
    
    def to_s
        "tl->(x:#{@x1} y:#{@y1})/br->:(x:#{@x2} y:#{@y2})"
    end
    
    def to_css_style
        top     = @y1
        left    = @x1
        height  = @y2 - @y1
        width   = @x2 - @x1
        
        "position:absolute; top:#{top}px; left:#{left}px; height:#{height}px; width:#{width}px;"
    end
    
    def to_json
        
    end
    
end

