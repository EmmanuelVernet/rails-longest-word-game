class GamesController < ApplicationController
  require 'open-uri'
  require 'json'
  def new
    # display new random grid & form
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    # calculate score
    # raise
    @word = params[:word]
    @letters = params[:letters]
    @grid_check = @word.upcase.chars.all? { |character| @word.upcase.count(character) <= @letters.count(character) }
    dictionary_check = JSON.parse(URI.parse("https://dictionary.lewagon.com/#{@word}").read)
    if !@grid_check && !dictionary_check["found"] == false
      @score = 0
      @message = "Sorry #{@word} is not in the grid or an english one"
    elsif !@grid_check 
      @score = 0
      @message = "the given word is not in the grid"
    elsif !dictionary_check["found"] 
      @score = 0 
      @message = "the given word is not an english word"
    else
      @message = "well done"
      @score = (@word.length * 10)
      return @score
    end
  end
end
