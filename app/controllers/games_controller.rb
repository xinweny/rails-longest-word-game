require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    add_score(0)
    @letters = ('A'..'Z').to_a.sample(10)
    @string = @letters.join('').upcase
  end

  def score
    answer = params[:answer].upcase
    if valid?(answer) && english?(answer)
      @message = "Congratulations! #{answer} is a valid English word!"
      add_score(answer.length)
    elsif valid?(answer)
      @message = "Sorry but #{answer} does not seem to be a valid English word..."
    else
      @message = "Sorry but #{answer} can't be built out of #{params[:string]}"
    end
    @message
  end

  private

  def english?(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    JSON.parse(open(url).read)['found']
  end

  def valid?(answer)
    answer_array = answer.split('')
    answer_array.each do |letter|
      valid = params[:string].split('').delete(letter)
      return false if valid.nil?

      valid.delete(letter)
    end
    true
  end
end
