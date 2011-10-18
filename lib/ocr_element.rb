#coding:utf-8

require_relative 'hocr_box'
class OCRElement < HOCRBox
    
    include Enumerable
    
    attr_reader :ocr_class, :children
    attr_accessor :features
    
    class << self
        def create_from_html(ocr_element_html)
            create ocr_element_html
        end

        def create(ocr_element_html)
            ocr_class   = extract_ocr_class(ocr_element_html)
            coordinates = extract_coordinates(ocr_element_html)

            unless ocr_class == 'ocrx_word'
               children = extract_children(ocr_element_html)
            else
               children = extract_word_children(ocr_element_html)
            end

            case ocr_class
            when 'ocrx_block' then
               OCRBlock.new(ocr_class,children,coordinates)
            when 'ocr_par' then
               OCRParagraph.new(ocr_class,children,coordinates)
            when 'ocr_line' then
               OCRLine.new(ocr_class,children,coordinates)
            when 'ocrx_word' then
               OCRWord.new(ocr_class,children,coordinates)
            else
               OCRElement.new(ocr_class,children,coordinates)
            end
        end

        def extract_word_children(ocr_element_html)
            [ocr_element_html.text]
        end

        def extract_children(ocr_element_html)
               children = []
               for child_fragment_html in ocr_element_html.elements do
                       children << OCRElement.create(child_fragment_html)
               end
               #br Elemente ausfiltern
               children.reject { |child| child.ocr_class == nil}
        end
   

        def extract_coordinates(ocr_element_html)
           extract_coordinates_from_string ocr_element_html['title']
        end

        def extract_coordinates_from_string(s)
           s =~ /bbox (\d+) (\d+) (\d+) (\d+)/
           [$1, $2, $3, $4]
        end

        def extract_ocr_class(ocr_element_html)
           ocr_element_html['class']
        end
    end
    
    def initialize(ocr_class, children, coordinates)
        @children = children
        @ocr_class = ocr_class
        @features = []
        super coordinates
    end
    
    def each
        children.each do |child|
            yield child
        end
    end
    
    def to_s
        "#{self.class}:#{@features}#{ coordinates_to_s }->\n" + children.map { |c| "\t#{c.to_s}" }.join("\n")
    end
    
    def mark_in_rspec(color)
        "<span style='color: #{color}'>#{to_s}</span>"
    end
    
    def css_class_string
        if @features.empty?
            "#{@ocr_class}"
        else
            "#{@ocr_class}-#{features_to_css_class}"
        end
    end
    
    def to_image_html(options = {})
        zoom = options[:zoom] || 1
        display_class = options[:css_class] || css_class_string
        children_html = @children.map {|c| c.to_image_html(:zoom => zoom) }.join("")
        "<span class='#{ display_class }' style='#{ to_css_style(zoom) }' ></span>#{ children_html }"
    end
    
    def to_html( display_class = css_class_string, style = nil )
         children_html = @children.map {|c| c.to_html}.join("")
        "<span class='#{ display_class }'> #{ children_html } </span>"
    end
    
    def features_to_css_class
        @features.uniq.sort.join('_')
    end
    
end

class OCRWord < OCRElement
    
    def text
        children.flatten[0]
    end
    
    def to_s
        "#{text}:#{coordinates}->#{@features}"
    end
    
    def to_image_html(options = {})
        zoom = options[:zoom] || 1
        display_class = options[:css_class] || css_class_string
        "<span class='#{ css_class_string}' style='#{ to_css_style(zoom) }'>#{ text }</span>"
    end
    
    def to_html
        "<span class='#{ css_class_string }'>#{ text }</span>"
    end
    
end

class OCRLine < OCRElement
    
    def to_s
        "#{self.class} #{coordinates_to_s} ->[\n" + 
        words.map {|w| "#{w.coordinates_to_s}\t#{w.to_s}"}.join("\n") +
        "]" 
    end
    
    def simple_line
        "#{self.class} #{coordinates_to_s} ->[\n" + 
        words.map {|w| w.to_s}.join("\n") +
        "]"
    end
    
    def to_text
        words.map { |w| w.text }.join(" ")
    end
    
    alias :words :children
end

class OCRParagraph < OCRElement
    alias :lines :children
end

class OCRBlock < OCRElement
    alias :paragraphs :children
end

