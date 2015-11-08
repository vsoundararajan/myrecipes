require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.create(chefname: "bob", email: "bob@example.com")
    @recipe = @chef.recipes.build(name: "Veg Biriyani", summary: "Best biriyani ever", 
                  description: "description for biriyani")
  end

  test "recipe should be valid" do 
    assert @recipe.valid?
  end

  test "chef should be present for any recipe" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end

  test "name should be present" do
    @recipe.name = nil
    assert_not @recipe.valid?
  end

  test "name length shouldn't be too long" do
    @recipe.name = "a" * 101
    assert_not @recipe.valid?
  end


  test "name length shouldn't be too short" do
    @recipe.name = "abcd"
    assert_not @recipe.valid?
  end

  test "summary should be present" do
    @recipe.summary = nil
    assert_not @recipe.valid?
  end

  test "summary length shouldn't be too long" do
    @recipe.summary = "a" * 151
    assert_not @recipe.valid?
  end

  test "summary length shouldn't be too short" do
    @recipe.summary = "abcdefghi"
    assert_not @recipe.valid?
  end

  test "description should be present" do
    @recipe.description = nil
    assert_not @recipe.valid?
  end

  test "description length shouldn't be too long" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end

  test "description length shouldn't be too short" do
    @recipe.description = "a" * 19
    assert_not @recipe.valid?
  end

end
