# frozen_string_literal: true

# Init our encryptor object
class Encryptor
  def cipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation)
    Hash[characters.zip(rotated_characters)]
  end

  def encrypt_letter(letter, rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
  end

  def encrypt(string, rotation)
    letters = string.split('')

    result = []
    letters.collect do |letter|
      result.push(encrypt_letter(letter, rotation))
    end
    result.join
  end

  def decrypt(string, rotation)
    letters = string.split('')

    result = []

    letters.collect do |letter|
      result.push(encrypt_letter(letter, -rotation.to_i))
    end
    result.join
  end
end
