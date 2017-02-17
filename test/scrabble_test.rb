gem 'minitest'
require_relative '../lib/scrabble'
require 'minitest/autorun'
require 'minitest/emoji'
require 'pry'

class ScrabbleTest < Minitest::Test

  attr_reader :game

  def setup
    @game = Scrabble.new
  end

  def test_it_can_score_a_single_letter
    assert_equal 1, game.score("a")
    assert_equal 4, game.score("f")
  end

  def test_it_can_score_a_word
    assert_equal 8, game.score("hello")
    assert_equal 0, game.score("")
  end

  def test_it_can_handle_nil
    assert_equal 0, game.score(nil)
  end

  def test_it_can_multiply_letter_scores
    assert_equal 9, game.score_with_multipliers("hello", [1,2,1,1,1])
    assert_equal -1, game.score_with_multipliers("hello", [1,2,1,1])
  end

  def test_it_can_multiply_word_scores
    assert_equal 18, game.score_with_multipliers('hello', [1,2,1,1,1], 2)
  end

  def test_it_should_add_7_letter_bonus
    assert_equal 58, game.score_with_multipliers('sparkle', [1,2,1,3,1,2,1], 2)
  end

  def test_it_identifies_the_highest_scoring_word
    assert_equal "home", game.highest_scoring_word(['home', 'word', 'hello', 'sound'])
  end
end
