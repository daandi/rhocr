#coding: utf-8

class HOCRBox
    
    attr_reader :left, :top, :right, :bottom, :upper_left, :lower_right, :coordinates
    def initialize(* coordinates)
        
        left,top,right,bottom = coordinates.flatten.collect { |x| x.to_i}
        
        if left > right || top > bottom then
            raise " Negative dimensions of OCRBox ar not allowed. left #{left} / right #{right} - top {top} / bottom #{bottom}"
        end
        
        @left = left
        @top = top
        @right = right
        @bottom = bottom
        @upper_left = [ @left, @top]
        @lower_rigth = [ @right, @bottom ]
        @coordinates = [ @left, @top,@right, @bottom ]
    end
    
    def encloses?(element)
        @left <= element.left and 
        @right >= element.right and
        @top <= element.top and 
        @bottom >= element.bottom
    end
    
    def enclosed_by?(element)
        return element.encloses? self
    end
    
    def left_of?(element)
        @right < element.left
    end
    
    def right_of?(element)
        @left > element.right
    end
    
    def left_distance_to(element)
        @left - element.right
    end
    
    def right_distance_to(element)
        #element.left - @right
        element.left_distance_to(self)
    end
    
    def to_s
        coordinates_to_s
    end
    
    def coordinates_to_s
        "(#{@left},#{@top})/(#{@right},#{@bottom})" 
    end
    
    def to_css_style
        height  = @bottom - @top
        width   = @right - @left
        
        "position:absolute; top:#{@top}px; left:#{@left}px; height:#{height}px; width:#{width}px;"
    end
    
    def to_html(css_class = 'hocr_box')
        "<span style='#{ to_css_style }' class='#{css_class}'></span>"
    end
    
    
end

