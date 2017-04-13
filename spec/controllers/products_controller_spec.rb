require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:product){FactoryGirl.create(:product)}
  let(:product_1){FactoryGirl.create(:product)}

  describe "Index Action" do
    it 'assigns a variable for all the products' do
      product
      product_1
      get :index
      expect(assigns(:products)).to eq([product, product_1])
    end

    it 'renders the index view' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "Show Action" do
    it 'assigns a varible for the product with the passed in id' do
      get :show, params: { id: product.id}
      expect(assigns(:product)).to eq(product)
    end
    it 'renders the show template' do
      get :show, params: {id: product.id}
      expect(response).to render_template(:show)
    end
  end

  describe 'New Action' do
    it 'assigns an instant variable' do
      get :new
      expect(assigns(:product)).to be_a_new(Product)

    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'Create Action' do
    context 'with valid attributes' do
      def valid_request
        post :create, params: {product: FactoryGirl.attributes_for(:product)}
      end

      it 'creates a new product in the database' do
        count_before = Product.count
        valid_request
        count_after = Product.count
        expect(count_after).to eq(count_before + 1)
      end

      it 'redirects to the product show page' do
        valid_request
        expect(response).to redirect_to(product_path(Product.last))
      end

          it 'sets a flash message' do
          valid_request
          expect(flash[:notice]).to be
        end
    end
  end

end
