#coding: utf-8
require 'sinatra'

require_relative '../lib/rhocr'

get '/' do
    "<a href='OCRTest.html'>OCRTest</a>"
end

get '/mark' do
    x1 = params[:x1]
    y1 = params[:y1]
    x2 = params[:x2]
    y2 = params[:y2]
    page = params[:page]
    
    if x1 and y1 and x2 and y2 and page then
       words = get_enclosed_words(x1, y1, x2, y2, page).join("<br/>")
       words
    else
        "Not enough parameters"
    end
    
end

def get_enclosed_words(x1, y1, x2 ,y2, page)
    @page = OCRPage.new("../data/#{page}")
    @page.enclosed_words( HOCRBox.new(x1, y1, x2 ,y2) )
end