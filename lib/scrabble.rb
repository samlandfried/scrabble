class Scrabble

  def score(word)
    return 0 if word.nil? || word.empty?

    word.upcase.chars.map do |letter|
      point_values[letter]
    end.reduce(:+)
  end

  def score_with_multipliers(word,
                            letter_multiplier = Array.new(word.nil? ? 0 : word.length) { |i| i = 1  },
                            word_multiplier=1)
    return 0 if word.nil? || word.empty?
    return -1 if word.length != letter_multiplier.length

    score_bonus = word.length >= 7 ? 10 : 0

    score = word.upcase.chars.map.with_index do |letter, index|
      point_values[letter] * letter_multiplier[index]
    end.reduce(:+)
    score += score_bonus
    score * word_multiplier
  end

  def highest_scoring_word(words)
    words.max do |word1, word2|
      score(word1) <=> score(word2)
    end
  end

  def point_values
    {
      "A"=>1, "B"=>3, "C"=>3, "D"=>2,
      "E"=>1, "F"=>4, "G"=>2, "H"=>4,
      "I"=>1, "J"=>8, "K"=>5, "L"=>1,
      "M"=>3, "N"=>1, "O"=>1, "P"=>3,
      "Q"=>10, "R"=>1, "S"=>1, "T"=>1,
      "U"=>1, "V"=>4, "W"=>4, "X"=>8,
      "Y"=>4, "Z"=>10
    }
  end
end
