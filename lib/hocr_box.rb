#coding: utf-8

class HOCRBox
    
    attr_reader :left, :top, :right, :bottom, :upper_left, :lower_right, :coordinates
    def initialize(* coordinates)
        
        @left, @top, @right, @bottom = coordinates.flatten.collect { |x| x.to_i}
        
        @height  = @bottom - @top
        @width   = @right - @left
        @upper_left = [ @left, @top]
        @lower_rigth = [ @right, @bottom ]
        @coordinates = [ @left, @top,@right, @bottom ]
        
        if left > right || top > bottom then
            raise " Negative dimensions of OCRBox ar not allowed. left #{@left} / right #{@right} - top #{@top} / bottom #{@bottom}"
        end
        
    end
    
    def encloses?(other)
        @left <= other.left and 
        @right >= other.right and
        @top <= other.top and 
        @bottom >= other.bottom
    end
    
    def enclosed_by?(other)
        return other.encloses? self
    end
    
    def left_of?(other)
        @right < other.left
    end
    
    def right_of?(other)
        @left > other.right
    end
    
    def left_distance_to(other)
        @left - other.right
    end
    
    def right_distance_to(other)
        other.left_distance_to(self)
    end
    
    def top_distance_to(other)
        @top - other.bottom
    end
    
    def bottom_distance_to(other)
        other.top_distance_to(self)
    end
    
    def to_s
        coordinates_to_s
    end
    
    def coordinates_to_s
        "(#{@left},#{@top})/(#{@right},#{@bottom})" 
    end
    
    def to_css_style
        "position:absolute; top:#{@top}px; left:#{@left}px; height:#{@height}px; width:#{@width}px;"
    end
    
    def to_image_html(css_class = 'hocr_box')
        "<span style='#{ to_css_style }' class='#{css_class}'></span>"
    end
    
    
end

