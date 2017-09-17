require 'test_helper'

class ChefTest < ActiveSupport::TestCase

	def setup
		@chef = Chef.new(chefname: "john", email: "john@example.com")
	end

	test "chef be valid " do 
		assert @chef.valid?
	end

	test "chefname be present" do
		@chef.chefname = " "
		assert_not @chef.valid?
	end

	test "chefname not be too long" do
		@chef.chefname = "a"*101
		assert_not @chef.valid?
	end

	test "chefname not be too short" do
		@chef.chefname = "aa"
		assert_not @chef.valid?
	end

	test "email be present" do
		@chef.email = " "
		assert_not @chef.valid?
	end

	test "email be unique" do
		dup_chef = @chef.dup
		dup_chef.email = @chef.email.upcase
		@chef.save
		assert_not dup_chef.valid?
	end

	test "email be valid" do
		valid_addresses = %w[user@example.com user@gmail.com]
		valid_addresses.each do |va|
			@chef.email = va
			assert @chef.valid?, '#{va.inspect} should be valid'
		end
	end

	test "email validations to check invalid addresses"do
		invalid_addresses = %w[user@example,com user@gmail,com]
		invalid_addresses.each do |ia|
			@chef.email = ia
			assert_not @chef.valid? '#{ia.inspect} should be invalid'
		end
	end
end