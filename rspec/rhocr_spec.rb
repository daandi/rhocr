require_relative '../lib/rhocr'

describe RHOCR do
    # Adds a big folder, takes some time, set long to true to test
    long = false
    if long then
          it 'should create ocr_pages given a folder #add_folder' do
            start = Time.now()
            test_folder = "data/bsb10413454/hocr/*.html"
            @rhocr_doc.add_folder(test_folder)
            puts " It took #{ (Time.now - start).to_i } seconds to process pages"
        end
    end
    
    before(:each) do
        @rhocr_doc ||= RHOCR.new.add_folder "data/*.html"
    end
    
    describe 'methods to iterate' do
        it 'should have lines' do
            @rhocr_doc.lines.length.should == 129
        end
        
        it 'should have words' do
            @rhocr_doc.words.length.should == 1120
        end
    end
    
    
end