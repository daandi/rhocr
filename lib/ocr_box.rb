module OCRBox
    
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
    
    def to_s
        "(#{@x1},#{@y1}) / (#{@x2},#{@y2})"
    end
    
    def to_css_style
        top     = @y1
        left    = @x1
        height  = @y2 - @y1
        width   = @x2 - @x1
        
        "position:absolute; top:#{top}px; left:#{left}px; height:#{height}px; width:#{width}px;"
    end
    
end

