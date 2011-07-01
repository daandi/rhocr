#coding: utf-8

require_relative '../lib/ocr_page'

describe OCRPage do
  
  before(:each) do
      @ocr_page ||= OCRPage.new('../data/Seite_Tagebuch_H_C_Lang_08.html')
  end
  
  describe '' do
      it '' do
          p @ocr_page.enclosed_words( OCRBox.new(500,1703,1200,1800) )
          
          
      end
  end
  
end
