require 'minitest/autorun'
require_relative 'hangman.rb'

class Testhangmanfunctions < Minitest::Test

	def test_class_returns_name
		hangman = Hangman.new("Gatton")
		assert_equal(6,hangman.charcount)
	end

	def test_class_returns_six_blanks
		hangman = Hangman.new("Gatton")
		assert_equal(["_","_","_","_","_","_"],hangman.blank)
	end

	def test_class_returns_password
		hangman = Hangman.new("dinosaur")
		assert_equal(["_","_","_","_","_","_","_","_"],hangman.name)
	end

	def test_class_guess_already_guessed
		hangman = Hangman.new("dinosaur")
		hangman.guessed = ["r", "g", "w"]
		letter = "g"
		assert_equal(true, hangman.available_guess(letter))
	end
end