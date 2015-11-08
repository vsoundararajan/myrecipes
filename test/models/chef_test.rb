require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.new(chefname: "Soundararajan", email: "efgh@usa.net")
  end

  test "chef should be valid" do 
    assert @chef.valid?
  end

  test "chefname should be present" do
    @chef.chefname = nil
    assert_not @chef.valid?
  end

  test "chefname should not be too long" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end

  test "chefname should not be too short" do
    @chef.chefname = "aa" 
    assert_not @chef.valid?
  end

  test "chef email should be present" do
    @chef.email = nil
    assert_not @chef.valid?
  end

  test "chef email should be within bounds" do
    @chef.email = "a" * 101 + "@example.com"
    assert_not @chef.valid?
  end

  test "proper chef email should be valid." do
    valid_email_addresses = %w[chefuser@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eeu.au laura+joe@monk.cm]
    valid_email_addresses.each do |email|
      @chef.email = email
      assert @chef.valid?, "#{email.inspect} should be valid"
    end
  end



  test "chef email should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end

end
