require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def checks(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = open(url).read
    response = JSON.parse(user_serialized)
    if response['found'] == true
      "Well done, it's an English word"
    else
      'Not an English word'
    end
  end

  def check_grid(word, letters)
    grid_array = letters.split('')
    attempt_array = word.split('')
    count = 0
    attempt_array.each do |letter|
      letter.upcase!
      count += 1 if grid_array.include? letter
    end
    if word.length < count || word.length <= 1
      'Your word is invalid'
    else
      'Your word is valid'
    end
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @valid_message = check_grid(@word, @letters)
    @english_message = checks(@word)
  end
end
