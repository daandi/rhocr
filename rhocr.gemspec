# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rhocr}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andreas Neumann"]
  s.date = %q{2011-07-03}
  s.description = %q{Manipulate and use OCR data encode in HOCR}
  s.email = %q{info @nospam@ an-it.com}
  s.extra_rdoc_files = ["README", "lib/ocr_box.rb", "lib/ocr_page.rb", "lib/ocrx_word.rb", "lib/rhocr.rb"]
  s.files = ["Manifest", "README", "Rakefile", "data/Seite_Tagebuch_H_C_Lang_08.html", "example/example_server.rb", "example/public/OCRTest.css", "example/public/OCRTest.html", "example/public/OCRTest_marker.js", "example/public/img/Seite_Tagebuch_H_C_Lang_05.jpg", "example/public/img/Seite_Tagebuch_H_C_Lang_08.jpg", "lib/ocr_box.rb", "lib/ocr_page.rb", "lib/ocrx_word.rb", "lib/rhocr.rb", "rhocr.gemspec", "rspec/ocr_box_spec.rb", "rspec/ocr_page_spec.rb", "rspec/ocrx_word_spec.rb"]
  s.homepage = %q{http://github.com/daandi/rhocr}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Rhocr", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rhocr}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Manipulate and use OCR data encode in HOCR}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
