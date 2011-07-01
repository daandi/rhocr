# coding: utf-8
require_relative "lib/ocr_page.rb"

ocr = OCRPage.new("data/Seite_Tagebuch_H_C_Lang_08.html")

p ocr.lines[1]
p ocr.words

