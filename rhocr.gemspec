# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rhocr}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Andreas Neumann}]
  s.date = %q{2011-09-08}
  s.description = %q{Manipulate and use OCR data encode in HOCR}
  s.email = %q{andreas@neumann.biz}
  s.extra_rdoc_files = [%q{README}, %q{TODO.txt}, %q{lib/hocr_box.rb}, %q{lib/ocr_document.rb}, %q{lib/ocr_element.rb}, %q{lib/ocr_page.rb}, %q{lib/rhocr.rb}]
  s.files = [%q{Manifest}, %q{README}, %q{Rakefile}, %q{TODO.txt}, %q{data/Seite_Die_Gartenlaube_242.html}, %q{data/Seite_Tagebuch_H_C_Lang_08.html}, %q{data/Seite_Tagebuch_H_C_Lang_08.jpg}, %q{data/test.html}, %q{data/test.png}, %q{example/example_server.rb}, %q{example/public/OCRTest.css}, %q{example/public/OCRTest.html}, %q{example/public/OCRTest_marker.js}, %q{example/public/Seite_Tagebuch_H_C_Lang_08.jpg}, %q{example/public/img/Seite_Tagebuch_H_C_Lang_08.jpg}, %q{lib/hocr_box.rb}, %q{lib/ocr_document.rb}, %q{lib/ocr_element.rb}, %q{lib/ocr_page.rb}, %q{lib/rhocr.rb}, %q{rhocr.gemspec}, %q{spec/hocr_box_spec.rb}, %q{spec/ocr_document_spec.rb}, %q{spec/ocr_element_spec.rb}, %q{spec/ocr_page_spec.rb}, %q{spec/rhocr_spec.rb}, %q{test.html}]
  s.homepage = %q{http://github.com/daandi/rhocr}
  s.rdoc_options = [%q{--line-numbers}, %q{--inline-source}, %q{--title}, %q{Rhocr}, %q{--main}, %q{README}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{rhocr}
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Manipulate and use OCR data encode in HOCR}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
    else
      s.add_dependency(%q<nokogiri>, [">= 0"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 0"])
  end
end
