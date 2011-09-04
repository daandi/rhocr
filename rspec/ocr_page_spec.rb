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
        @output_page ||= OCRPage.new 'data/bsb_test.html', 'data/bsb_test_big.jpg'
    end
    
    it 'should have a #to_text method' do
        @output_page.to_text.should  == "Athenobius — Aulon. 29\nAthenobius, Der von der Göttin Minerva lebt, oder: Mi»\nnerva Bogen.\nDes Königs Antiochus Freund oder geheimer Nath. l Mack.\n15, 28.\nAthlai. Dee Herr zerreißet oder zerbricht. Einer von den\nNachlommen Bebai. Esra 10, 28.\nAthni. Eine Trübsal von Gott. Ein Sohn Semaja. 1 Chron.\n27. 7.\nAthniel. Gottes Trübsal, d. i. eine Trübsal, von Gott zugesügt.\nEin Sohn Kenas, des Bruders Kaleb; gewann Kiriath Sepher, und\ndamit Achsa. die Tochter seines Betters Kaleb. Nicht, 1. 12. 13.\nAtroth-Sophan, die Krone oder Decke, oder Bedeckung des'\nHügels. Eine Stadt der Rubeniten im Königreich Sthon. 4 Mos.\n32, 35.\nAtrothAddar: Die Krone Addar (des Sohnes Benjamin). Diese\nStadt gehörte den Benjaminitern, lag in den Grenzen Iuda tmd\nEphraim.\nAtroth.Beth-Ioab, d. i. die Krone des Hauses Ioab. Eine\nStadt in Iuda, wo die Nachlommen Salma gewohnt haben. 1 Chron.\n2, 54.\nAttalia. Eine Stadt in Pamphilien od. Libyen, von Attala Phila.\ndelpho erbaut. Ap. Gesch. 14, 25.\nAttalus Ein König in Mysien, welches unter Phrygien gehörte; ,\ngenannt von Attale, welches bei den Phrygiern Kropf oder Gurgel\ngeheißen haben soll. , War ein König der Pergamener und Phrvgier.\nl Mack. 15, 22.\nAva. Ist bei den alten Griechen Aia od. Aea, die Hauptstadt in Col»\nchide, wo Aetas regierte. Colchis heißt heutiges Tages Mengrelicn,\ndie meisten Einwohner sind Christen. Von hier wurden die Leute\nvon Salmanasscr nach Samaria gesührt, wo sie noch ihre Götter\nNibehas und Tharthac anbeteten. 2 Kön. l7, 24. 31.\nAven. Götze, Eitelleit. So wird Bethel genannt. Hos. 10, 8.\nwegen der Götzen, die daselbst von den Israeliten verehrt wurden.\nMit dem ganzen Namen: Beth»Aven, das Götzenhaus, oder, da man\ndem Eiteln nachwandelt. Hos. 4, 15.\nAugustus. Würdig verehrt und angebetet zu werden.\nDiesen Namen gab das romische Voll dem Kaiser Octavian, und\nalle romischen Kaiser haben diesen Namen beibehalten, daß sie «au,-\nper 2ußr>«ti, d. i, allzeit Mehrer des Reichs geheißen haben.\nAvith. Haufe. Eine Stadt in Idumäa. 1 Mos. 36, 35.\nAulon. Ausgehöhlt. Das große Thal, worin die berühmten\nStädte Vethsan oder Scythopolis, Tlberias, Iericho, das todte Meer"
    end
    
    it 'should have a #to_html method' do
        @output_page.to_html.should == "<span class='ocr_page'> <span class='ocrx_block'> <span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>Athenobius</span><span class='ocrx_word'>—</span><span class='ocrx_word'>Aulon.</span><span class='ocrx_word'>29</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>Athenobius,</span><span class='ocrx_word'>Der</span><span class='ocrx_word'>von</span><span class='ocrx_word'>der</span><span class='ocrx_word'>Göttin</span><span class='ocrx_word'>Minerva</span><span class='ocrx_word'>lebt,</span><span class='ocrx_word'>oder:</span><span class='ocrx_word'>Mi»</span> </span><span class='ocr_line'> <span class='ocrx_word'>nerva</span><span class='ocrx_word'>Bogen.</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>Des</span><span class='ocrx_word'>Königs</span><span class='ocrx_word'>Antiochus</span><span class='ocrx_word'>Freund</span><span class='ocrx_word'>oder</span><span class='ocrx_word'>geheimer</span><span class='ocrx_word'>Nath.</span><span class='ocrx_word'>l</span><span class='ocrx_word'>Mack.</span> </span><span class='ocr_line'> <span class='ocrx_word'>15,</span><span class='ocrx_word'>28.</span> </span><span class='ocr_line'> <span class='ocrx_word'>Athlai.</span><span class='ocrx_word'>Dee</span><span class='ocrx_word'>Herr</span><span class='ocrx_word'>zerreißet</span><span class='ocrx_word'>oder</span><span class='ocrx_word'>zerbricht.</span><span class='ocrx_word'>Einer</span><span class='ocrx_word'>von</span><span class='ocrx_word'>den</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>Nachlommen</span><span class='ocrx_word'>Bebai.</span><span class='ocrx_word'>Esra</span><span class='ocrx_word'>10,</span><span class='ocrx_word'>28.</span> </span><span class='ocr_line'> <span class='ocrx_word'>Athni.</span><span class='ocrx_word'>Eine</span><span class='ocrx_word'>Trübsal</span><span class='ocrx_word'>von</span><span class='ocrx_word'>Gott.</span><span class='ocrx_word'>Ein</span><span class='ocrx_word'>Sohn</span><span class='ocrx_word'>Semaja.</span><span class='ocrx_word'>1</span><span class='ocrx_word'>Chron.</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>27.</span><span class='ocrx_word'>7.</span> </span><span class='ocr_line'> <span class='ocrx_word'>Athniel.</span><span class='ocrx_word'>Gottes</span><span class='ocrx_word'>Trübsal,</span><span class='ocrx_word'>d.</span><span class='ocrx_word'>i.</span><span class='ocrx_word'>eine</span><span class='ocrx_word'>Trübsal,</span><span class='ocrx_word'>von</span><span class='ocrx_word'>Gott</span><span class='ocrx_word'>zugesügt.</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>Ein</span><span class='ocrx_word'>Sohn</span><span class='ocrx_word'>Kenas,</span><span class='ocrx_word'>des</span><span class='ocrx_word'>Bruders</span><span class='ocrx_word'>Kaleb;</span><span class='ocrx_word'>gewann</span><span class='ocrx_word'>Kiriath</span><span class='ocrx_word'>Sepher,</span><span class='ocrx_word'>und</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>damit</span><span class='ocrx_word'>Achsa.</span><span class='ocrx_word'>die</span><span class='ocrx_word'>Tochter</span><span class='ocrx_word'>seines</span><span class='ocrx_word'>Betters</span><span class='ocrx_word'>Kaleb.</span><span class='ocrx_word'>Nicht,</span><span class='ocrx_word'>1.</span><span class='ocrx_word'>12.</span><span class='ocrx_word'>13.</span> </span><span class='ocr_line'> <span class='ocrx_word'>Atroth-Sophan,</span><span class='ocrx_word'>die</span><span class='ocrx_word'>Krone</span><span class='ocrx_word'>oder</span><span class='ocrx_word'>Decke,</span><span class='ocrx_word'>oder</span><span class='ocrx_word'>Bedeckung</span><span class='ocrx_word'>des'</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>Hügels.</span><span class='ocrx_word'>Eine</span><span class='ocrx_word'>Stadt</span><span class='ocrx_word'>der</span><span class='ocrx_word'>Rubeniten</span><span class='ocrx_word'>im</span><span class='ocrx_word'>Königreich</span><span class='ocrx_word'>Sthon.</span><span class='ocrx_word'>4</span><span class='ocrx_word'>Mos.</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>32,</span><span class='ocrx_word'>35.</span> </span><span class='ocr_line'> <span class='ocrx_word'>AtrothAddar:</span><span class='ocrx_word'>Die</span><span class='ocrx_word'>Krone</span><span class='ocrx_word'>Addar</span><span class='ocrx_word'>(des</span><span class='ocrx_word'>Sohnes</span><span class='ocrx_word'>Benjamin).</span><span class='ocrx_word'>Diese</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>Stadt</span><span class='ocrx_word'>gehörte</span><span class='ocrx_word'>den</span><span class='ocrx_word'>Benjaminitern,</span><span class='ocrx_word'>lag</span><span class='ocrx_word'>in</span><span class='ocrx_word'>den</span><span class='ocrx_word'>Grenzen</span><span class='ocrx_word'>Iuda</span><span class='ocrx_word'>tmd</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>Ephraim.</span> </span><span class='ocr_line'> <span class='ocrx_word'>Atroth.Beth-Ioab,</span><span class='ocrx_word'>d.</span><span class='ocrx_word'>i.</span><span class='ocrx_word'>die</span><span class='ocrx_word'>Krone</span><span class='ocrx_word'>des</span><span class='ocrx_word'>Hauses</span><span class='ocrx_word'>Ioab.</span><span class='ocrx_word'>Eine</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>Stadt</span><span class='ocrx_word'>in</span><span class='ocrx_word'>Iuda,</span><span class='ocrx_word'>wo</span><span class='ocrx_word'>die</span><span class='ocrx_word'>Nachlommen</span><span class='ocrx_word'>Salma</span><span class='ocrx_word'>gewohnt</span><span class='ocrx_word'>haben.</span><span class='ocrx_word'>1</span><span class='ocrx_word'>Chron.</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>2,</span><span class='ocrx_word'>54.</span> </span><span class='ocr_line'> <span class='ocrx_word'>Attalia.</span><span class='ocrx_word'>Eine</span><span class='ocrx_word'>Stadt</span><span class='ocrx_word'>in</span><span class='ocrx_word'>Pamphilien</span><span class='ocrx_word'>od.</span><span class='ocrx_word'>Libyen,</span><span class='ocrx_word'>von</span><span class='ocrx_word'>Attala</span><span class='ocrx_word'>Phila.</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>delpho</span><span class='ocrx_word'>erbaut.</span><span class='ocrx_word'>Ap.</span><span class='ocrx_word'>Gesch.</span><span class='ocrx_word'>14,</span><span class='ocrx_word'>25.</span> </span><span class='ocr_line'> <span class='ocrx_word'>Attalus</span><span class='ocrx_word'>Ein</span><span class='ocrx_word'>König</span><span class='ocrx_word'>in</span><span class='ocrx_word'>Mysien,</span><span class='ocrx_word'>welches</span><span class='ocrx_word'>unter</span><span class='ocrx_word'>Phrygien</span><span class='ocrx_word'>gehörte;</span><span class='ocrx_word'>,</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>genannt</span><span class='ocrx_word'>von</span><span class='ocrx_word'>Attale,</span><span class='ocrx_word'>welches</span><span class='ocrx_word'>bei</span><span class='ocrx_word'>den</span><span class='ocrx_word'>Phrygiern</span><span class='ocrx_word'>Kropf</span><span class='ocrx_word'>oder</span><span class='ocrx_word'>Gurgel</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>geheißen</span><span class='ocrx_word'>haben</span><span class='ocrx_word'>soll.</span><span class='ocrx_word'>,</span><span class='ocrx_word'>War</span><span class='ocrx_word'>ein</span><span class='ocrx_word'>König</span><span class='ocrx_word'>der</span><span class='ocrx_word'>Pergamener</span><span class='ocrx_word'>und</span><span class='ocrx_word'>Phrvgier.</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>l</span><span class='ocrx_word'>Mack.</span><span class='ocrx_word'>15,</span><span class='ocrx_word'>22.</span> </span><span class='ocr_line'> <span class='ocrx_word'>Ava.</span><span class='ocrx_word'>Ist</span><span class='ocrx_word'>bei</span><span class='ocrx_word'>den</span><span class='ocrx_word'>alten</span><span class='ocrx_word'>Griechen</span><span class='ocrx_word'>Aia</span><span class='ocrx_word'>od.</span><span class='ocrx_word'>Aea,</span><span class='ocrx_word'>die</span><span class='ocrx_word'>Hauptstadt</span><span class='ocrx_word'>in</span><span class='ocrx_word'>Col»</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>chide,</span><span class='ocrx_word'>wo</span><span class='ocrx_word'>Aetas</span><span class='ocrx_word'>regierte.</span><span class='ocrx_word'>Colchis</span><span class='ocrx_word'>heißt</span><span class='ocrx_word'>heutiges</span><span class='ocrx_word'>Tages</span><span class='ocrx_word'>Mengrelicn,</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>die</span><span class='ocrx_word'>meisten</span><span class='ocrx_word'>Einwohner</span><span class='ocrx_word'>sind</span><span class='ocrx_word'>Christen.</span><span class='ocrx_word'>Von</span><span class='ocrx_word'>hier</span><span class='ocrx_word'>wurden</span><span class='ocrx_word'>die</span><span class='ocrx_word'>Leute</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>von</span><span class='ocrx_word'>Salmanasscr</span><span class='ocrx_word'>nach</span><span class='ocrx_word'>Samaria</span><span class='ocrx_word'>gesührt,</span><span class='ocrx_word'>wo</span><span class='ocrx_word'>sie</span><span class='ocrx_word'>noch</span><span class='ocrx_word'>ihre</span><span class='ocrx_word'>Götter</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>Nibehas</span><span class='ocrx_word'>und</span><span class='ocrx_word'>Tharthac</span><span class='ocrx_word'>anbeteten.</span><span class='ocrx_word'>2</span><span class='ocrx_word'>Kön.</span><span class='ocrx_word'>l7,</span><span class='ocrx_word'>24.</span><span class='ocrx_word'>31.</span> </span><span class='ocr_line'> <span class='ocrx_word'>Aven.</span><span class='ocrx_word'>Götze,</span><span class='ocrx_word'>Eitelleit.</span><span class='ocrx_word'>So</span><span class='ocrx_word'>wird</span><span class='ocrx_word'>Bethel</span><span class='ocrx_word'>genannt.</span><span class='ocrx_word'>Hos.</span><span class='ocrx_word'>10,</span><span class='ocrx_word'>8.</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>wegen</span><span class='ocrx_word'>der</span><span class='ocrx_word'>Götzen,</span><span class='ocrx_word'>die</span><span class='ocrx_word'>daselbst</span><span class='ocrx_word'>von</span><span class='ocrx_word'>den</span><span class='ocrx_word'>Israeliten</span><span class='ocrx_word'>verehrt</span><span class='ocrx_word'>wurden.</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>Mit</span><span class='ocrx_word'>dem</span><span class='ocrx_word'>ganzen</span><span class='ocrx_word'>Namen:</span><span class='ocrx_word'>Beth»Aven,</span><span class='ocrx_word'>das</span><span class='ocrx_word'>Götzenhaus,</span><span class='ocrx_word'>oder,</span><span class='ocrx_word'>da</span><span class='ocrx_word'>man</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>dem</span><span class='ocrx_word'>Eiteln</span><span class='ocrx_word'>nachwandelt.</span><span class='ocrx_word'>Hos.</span><span class='ocrx_word'>4,</span><span class='ocrx_word'>15.</span> </span><span class='ocr_line'> <span class='ocrx_word'>Augustus.</span><span class='ocrx_word'>Würdig</span><span class='ocrx_word'>verehrt</span><span class='ocrx_word'>und</span><span class='ocrx_word'>angebetet</span><span class='ocrx_word'>zu</span><span class='ocrx_word'>werden.</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>Diesen</span><span class='ocrx_word'>Namen</span><span class='ocrx_word'>gab</span><span class='ocrx_word'>das</span><span class='ocrx_word'>romische</span><span class='ocrx_word'>Voll</span><span class='ocrx_word'>dem</span><span class='ocrx_word'>Kaiser</span><span class='ocrx_word'>Octavian,</span><span class='ocrx_word'>und</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>alle</span><span class='ocrx_word'>romischen</span><span class='ocrx_word'>Kaiser</span><span class='ocrx_word'>haben</span><span class='ocrx_word'>diesen</span><span class='ocrx_word'>Namen</span><span class='ocrx_word'>beibehalten,</span><span class='ocrx_word'>daß</span><span class='ocrx_word'>sie</span><span class='ocrx_word'>«au,-</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>per</span><span class='ocrx_word'>2ußr>«ti,</span><span class='ocrx_word'>d.</span><span class='ocrx_word'>i,</span><span class='ocrx_word'>allzeit</span><span class='ocrx_word'>Mehrer</span><span class='ocrx_word'>des</span><span class='ocrx_word'>Reichs</span><span class='ocrx_word'>geheißen</span><span class='ocrx_word'>haben.</span> </span><span class='ocr_line'> <span class='ocrx_word'>Avith.</span><span class='ocrx_word'>Haufe.</span><span class='ocrx_word'>Eine</span><span class='ocrx_word'>Stadt</span><span class='ocrx_word'>in</span><span class='ocrx_word'>Idumäa.</span><span class='ocrx_word'>1</span><span class='ocrx_word'>Mos.</span><span class='ocrx_word'>36,</span><span class='ocrx_word'>35.</span> </span><span class='ocr_line'> <span class='ocrx_word'>Aulon.</span><span class='ocrx_word'>Ausgehöhlt.</span><span class='ocrx_word'>Das</span><span class='ocrx_word'>große</span><span class='ocrx_word'>Thal,</span><span class='ocrx_word'>worin</span><span class='ocrx_word'>die</span><span class='ocrx_word'>berühmten</span> </span> </span><span class='ocr_par'> <span class='ocr_line'> <span class='ocrx_word'>Städte</span><span class='ocrx_word'>Vethsan</span><span class='ocrx_word'>oder</span><span class='ocrx_word'>Scythopolis,</span><span class='ocrx_word'>Tlberias,</span><span class='ocrx_word'>Iericho,</span><span class='ocrx_word'>das</span><span class='ocrx_word'>todte</span><span class='ocrx_word'>Meer</span> </span> </span> </span> </span>"
    end
    
    it 'should have a #to_image_html method' do
        File.new('test.html','w+') << @output_page.to_image_html
                @output_page.to_image_html.should == ""
    end
  end
  

end