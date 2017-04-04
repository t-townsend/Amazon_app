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
        product = Product.new(valid_attributes({title: nil}))
        expect(product).to be_invalid
      end

      it 'requires unique titles' do
        product = Product.new(valid_attributes({ title: 'Hey Buddy'}))
        product2 = Product.new(valid_attributes({ title: 'Hey Buddy'}))
        product.save
        expect(product2).to be_invalid
      end

      it 'capitalizes the title after getting saved' do
        product = Product.new(valid_attributes({title: "mello yellow"}))
        product.save
        expect(product.title).to eq('Mello Yellow')

      end
    end
  end
end
