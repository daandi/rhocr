#coding: utf-8
require_relative '../lib/ocr_page'
require 'nokogiri'
require 'pp'

describe OCRPage do
  
  before(:each) do
      @test_page ||= OCRPage.new('data/bsb_test.html')
  end
  
  describe '#constructor and mehtods for construction' do
    it 'should work' do
        @test_page.should_not be_nil
    end
    
    it 'should have an extractor method for page dimensions and page number' do
        dimensions, page_number = @test_page.extract_bbox_ppageno "bbox 0 0 1326 1326;ppageno 33"
        page_number.should == 33
        dimensions.should == %w{ 0 0 1326 1326}
    end
    
    it 'should have an image attached'
  end
  
  describe 'Page' do
      it 'should have a #page_number' do
          @test_page.page_number.should_not be_nil
          @test_page.page_number.should == 33
      end
      
      it 'should have metedata'
      
      it 'page should have #coordinates' do
          @test_page.coordinates.should == [0,0,1326,1326]
      end
      it 'should have children' do
        @test_page.children.should_not == []
      end
  end
  
  
  describe '#Iterators' do
      it 'should have a block iterator #each_block' do
          a = []
          @test_page.each_block do |block|
             a << block
          end
          a.length.should == 1
      end
      it 'should have a paragraph iterator #each_paragraph' do
          a = []
          @test_page.each_paragraph do |paragraph|
              a << paragraph
          end
          a.length.should == 28
      end
      it 'should have a line iterator #each_line' do
          a = []
          @test_page.each_line do |line|
                a << line
            end
          a.length.should == 43
      end
      it 'should have a word iterator #each_word' do
        a = []
        @test_page.each_word do |word|
            a << word
        end
        a.length.should == 346
      end
    
  end
  
  describe 'convinience methods' do
      it 'should have a method #lines' do
        @test_page.lines[5].children.length.should == 9
      end
  end
  
  describe ' display methods' do
    
    before(:each) do
        @output_page ||= OCRPage.new 'data/bsb_test.html', 'data/bsb_test.jpg'
    end
    
    it 'should have a #to_text method' do
        @output_page.to_text.should  == "Athenobius — Aulon. 29\nAthenobius, Der von der Göttin Minerva lebt, oder: Mi»\nnerva Bogen.\nDes Königs Antiochus Freund oder geheimer Nath. l Mack.\n15, 28.\nAthlai. Dee Herr zerreißet oder zerbricht. Einer von den\nNachlommen Bebai. Esra 10, 28.\nAthni. Eine Trübsal von Gott. Ein Sohn Semaja. 1 Chron.\n27. 7.\nAthniel. Gottes Trübsal, d. i. eine Trübsal, von Gott zugesügt.\nEin Sohn Kenas, des Bruders Kaleb; gewann Kiriath Sepher, und\ndamit Achsa. die Tochter seines Betters Kaleb. Nicht, 1. 12. 13.\nAtroth-Sophan, die Krone oder Decke, oder Bedeckung des'\nHügels. Eine Stadt der Rubeniten im Königreich Sthon. 4 Mos.\n32, 35.\nAtrothAddar: Die Krone Addar (des Sohnes Benjamin). Diese\nStadt gehörte den Benjaminitern, lag in den Grenzen Iuda tmd\nEphraim.\nAtroth.Beth-Ioab, d. i. die Krone des Hauses Ioab. Eine\nStadt in Iuda, wo die Nachlommen Salma gewohnt haben. 1 Chron.\n2, 54.\nAttalia. Eine Stadt in Pamphilien od. Libyen, von Attala Phila.\ndelpho erbaut. Ap. Gesch. 14, 25.\nAttalus Ein König in Mysien, welches unter Phrygien gehörte; ,\ngenannt von Attale, welches bei den Phrygiern Kropf oder Gurgel\ngeheißen haben soll. , War ein König der Pergamener und Phrvgier.\nl Mack. 15, 22.\nAva. Ist bei den alten Griechen Aia od. Aea, die Hauptstadt in Col»\nchide, wo Aetas regierte. Colchis heißt heutiges Tages Mengrelicn,\ndie meisten Einwohner sind Christen. Von hier wurden die Leute\nvon Salmanasscr nach Samaria gesührt, wo sie noch ihre Götter\nNibehas und Tharthac anbeteten. 2 Kön. l7, 24. 31.\nAven. Götze, Eitelleit. So wird Bethel genannt. Hos. 10, 8.\nwegen der Götzen, die daselbst von den Israeliten verehrt wurden.\nMit dem ganzen Namen: Beth»Aven, das Götzenhaus, oder, da man\ndem Eiteln nachwandelt. Hos. 4, 15.\nAugustus. Würdig verehrt und angebetet zu werden.\nDiesen Namen gab das romische Voll dem Kaiser Octavian, und\nalle romischen Kaiser haben diesen Namen beibehalten, daß sie «au,-\nper 2ußr>«ti, d. i, allzeit Mehrer des Reichs geheißen haben.\nAvith. Haufe. Eine Stadt in Idumäa. 1 Mos. 36, 35.\nAulon. Ausgehöhlt. Das große Thal, worin die berühmten\nStädte Vethsan oder Scythopolis, Tlberias, Iericho, das todte Meer"
    end
    
    it 'should have a #to_html method'
    
    it 'should have a #to_image_html method'
  end
  

end