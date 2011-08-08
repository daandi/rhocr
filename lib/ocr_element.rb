#coding:utf-8

require_relative 'hocr_box'
require 'nokogiri'

class OCRElement < HOCRBox
    
    attr_reader :ocr_class, :children, :coordinates
    
    def initialize(ocr_class, coordinates, children) 
        @ocr_class = ocr_class
        @coordinates = coordinates
        @children = children
    end
    
    def to_s
        "#{@ocr_class}:#{super}"
    end
    
end