require "minitest/autorun"
require_relative "isbn.rb"
class TestISBN_Machine < Minitest::Test

	def test_1_equals_1
		assert_equal(1,1)
	end

	def test_length_equals_10_or_13
		assert_equal(false,check_isbn("123456"))
	end
end