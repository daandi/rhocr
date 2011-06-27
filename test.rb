# coding: utf-8
require_relative "lib/hocr.rb"

hocr = HOCR.new("data/Seite_Tagebuch_H_C_Lang_08.html")

p hocr.lines[1]
p hocr.words

p hocr.enclosed_words(OCRBox.new(200,100,600,50))