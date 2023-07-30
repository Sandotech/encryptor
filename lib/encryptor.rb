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

  def encrypt_file(filename, rotation)
    input = File.open(filename, 'r')
    content = input.rewind && input.read
    output_content = encrypt(content, rotation)
    input.close
    output_file = File.open("#{filename}.encrypted", 'w')
    output_file.write(output_content)
    output_file.close
  end

  def decrypt_file(filename, rotation)
    encrypted_file = File.open(filename, 'r')
    encrypted_content = encrypted_file.rewind && encrypted_file.read
    decrypted_content = decrypt(encrypted_content, rotation)
    encrypted_file.close
    decrypt_file = File.open(filename.gsub('.encrypted', '.decrypted'), 'w')
    decrypt_file.write(decrypted_content)
    decrypt_file.close
  end
end
