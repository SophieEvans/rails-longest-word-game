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
    return response['found']
  end

  def english_message(word)
    if checks(word) == true
      "It's an English word"
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
      false
    else
      true
    end
  end

  def grid_message(word, letters)
    if check_grid(word, letters) == true
      'The letters of your word are valid'
    else
      'The letters of your word are not valid'
    end
  end

  def word_score(word, letters)
    if check_grid(word, letters) == true && checks(word) == true
      "Well done your score is #{word.length}!"
    else
      'Sorry, no score 😢'
    end
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @valid_message = grid_message(@word, @letters)
    @english_message = english_message(@word)
    @your_score = word_score(@word, @letters)
  end
end
