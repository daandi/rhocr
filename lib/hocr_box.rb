#coding: utf-8

class HOCRBox
    
    attr_reader :x1, :y1, :x2, :y2, :upper_left, :lower_right, :coordinates
    
    def initialize(* coordinates)
        
        x1,y1,x2,y2 = coordinates.flatten.collect { |x| x.to_i}
        
        if x1 > x2 || y1 > y2 then
            raise " Negative dimensions of OCRBox ar not allowed. x1 #{x1} / x2 #{x2} - y1 {y1} / y2 #{y2}"
        end
        
        @x1 = x1
        @y1 = y1
        @x2 = x2
        @y2 = y2
        @upper_left = [@x1,@y1]
        @lower_rigth = [@x2,@y2]
        @coordinates = [@x1,@y1,@x2,@y2]
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
    
    def left_of?(element)
        @x2 < element.x1
    end
    
    def right_of?(element)
        @x1 > element.x2
    end
    
    def left_distance_to(element)
        @x1 - element.x2
    end
    
    def right_distance_to(element)
        #element.x1 - @x2
        element.left_distance_to(self)
    end
    
    def to_s
        "#(#{@x1}/#{@y1},#{@x2}/#{@y2})" 
    end
    
    def to_css_style
        top     = @y1
        left    = @x1
        height  = @y2 - @y1
        width   = @x2 - @x1
        
        "position:absolute; top:#{top}px; left:#{left}px; height:#{height}px; width:#{width}px;"
    end
    
    
end

