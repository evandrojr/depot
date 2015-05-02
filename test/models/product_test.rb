require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  attr_accessor :product
  
  setup do
    @product = Product.new
    @product.image_url = "evandro.jpg"
    @product.price = 9
    @product.title = rand
  end

  test "product attributes must not be empty" do
    p = Product.new
    assert p.invalid?
    assert p.errors[:title].any?
    assert p.errors[:description].any?
    assert p.errors[:price].any?
    assert p.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(title:       "My Book Title",
                          description: "yyy",
                          image_url:   "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], 
      product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title:       "My Book Title",
                description: "yyy",
                price:       1,
                image_url:   image_url)
  end
  
  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
             http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    ok.each do |name|
      assert new_product(name).valid?, "#{name} should be valid"
    end
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(title:       "rand",
                          description: "yyy", 
                          price:       1, 
                          image_url:   "fred.gif")

    product.save!
    product = Product.new(title:       "rand",
                          description: "yyy", 
                          price:       1, 
                          image_url:   "fred.gif")
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end
end
