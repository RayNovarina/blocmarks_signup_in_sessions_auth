#
module RandomData
  def random_paragraph(min_length = 40, max_length = 500)
    paragraph = ''
    while (paragraph.length < min_length) && (paragraph.length < max_length) do
      rand(4..6).times do
        paragraph += (random_sentence(min_length, max_length) + ' ')
        if paragraph.length >= max_length
          break
        end
      end
    end
    # Note: we always get here with the string ending in a period and a space.
    if paragraph.length > max_length + 1
      # Truncate string to max size less one. Add a period.
      paragraph = paragraph[0, max_length - 1]
      paragraph += '.'
    else
      # Trim off the trailing space, leave the period.
      paragraph = paragraph[0, paragraph.length - 1]
    end
    paragraph
  end

  def random_sentence(min_length = 4, max_length = 200)
    sentence = ''
    while (sentence.length < min_length) && (sentence.length < max_length) do
      rand(3..8).times do
        sentence += (random_word + ' ')
        if sentence.length >= max_length
          break
        end
      end
    end
    # Note: we always get here with a trailing space.

    # If too long, truncate to max size less one (leave space for ending period)
    # Else trim off trailing space.
    sentence = sentence[0, (sentence.length > max_length ? max_length : sentence.length) - 1]
    sentence = (sentence + '.').capitalize
    sentence
  end

  def random_word
    letters = ('a'..'z').to_a
    letters.shuffle!
    letters[0, rand(3..8)].join
  end

  def random_price(min_value = 1, max_value = 100)
    rand(min_value..max_value)
  end

  def random_name
    first_name = random_word.capitalize
    last_name = random_word.capitalize
    "#{first_name} #{last_name}"
  end

  def random_email
    "#{random_word}@#{random_word}.#{random_word}"
  end
end
