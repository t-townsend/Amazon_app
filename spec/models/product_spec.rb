require 'rails_helper'

RSpec.describe Product, type: :model do
  def valid_attributes(new_attributes)
    attributes = {
      title: "Laptop",
      description: "Cool Computer",
      price: 100
    }
    attributes.merge(new_attributes)
  end

  describe "validations" do
    context "title" do
      it 'requires a title' do
        product = Product.new(valid_attributes({ title: nil }))
        expect(product).to be_invalid
      end
      it 'requires unique titles' do
        product = Product.new(valid_attributes({ title: "water bottle" }))
        product2 = Product.new(valid_attributes({ title: "water bottle" }))
        product.save
        expect(product2).to be_invalid
      end
      it 'capitalizes the title after getting saved' do
        product = Product.new(valid_attributes({ title: "glass mug" }))
        product.save
        expect(product.title).to eq("Glass Mug")
      end
    end

    context "description" do
      it 'requires a description' do
        product = Product.new(valid_attributes({ description: nil }))
        expect(product).to be_invalid
      end
    end

    context "price" do
      it 'requires a price' do
        product = Product.new(valid_attributes({ price: nil }))
        expect(product).to be_invalid
      end
      it 'requires a price greater than 0' do
        # product = Product.new(valid_attributes({ price: -1 }))
        # expect(product).to be_invalid
        product = Product.new(valid_attributes({ price: 0 }))
        product.save
        expect(product.errors.messages).to have_key(:price)
      end
    end

    context "search" do
      it 'can be searched by title' do
        product = Product.new(valid_attributes({ title: "water bottle" }))
        product.save
        product2 = Product.new(valid_attributes({ title: "Laptop" }))
        product2.save
        result = Product.search("Laptop")
        expect(result.first[:title]).to eq("Laptop")
      end
      it 'can be searched by description' do
        product = Product.new(valid_attributes({ description: "aluminum bottle" }))
        product.save
        product2 = Product.new(valid_attributes({ description: "computer" }))
        product2.save
        result = Product.search("aluminum bottle")
        expect(result.first[:description]).to eq("aluminum bottle")
      end
    end

  end
end
