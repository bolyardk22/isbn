require "minitest/autorun"
require_relative "isbn.rb"
class TestISBN_Machine < Minitest::Test

	def test_1_equals_1
		assert_equal(1,1)
	end

	def test_length_equals_six_fails
		assert_equal(false,check_isbn("123456"))
	end

	def test_length_equals_ten_passes
		assert_equal(true,check_isbn("1234567891"))
	end

	def test_removes_dashes
		assert_equal(true,check_isbn("123456789-1"))
	end
end