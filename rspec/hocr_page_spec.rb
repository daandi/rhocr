#coding: utf-8
require_relative '../lib/hocr_page'

describe HOCRPage do
  
  before(:each) do
      @hocr_page ||= HOCRPage.new('data/test.html')
  end
  
  describe 'HOCRPage' do
      it 'should have metedata' do
          p @ocr_page.meta_data
      end
  end
  
end

# Test
