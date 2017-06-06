require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:product) { FactoryGirl.create(:product, { user: user }) }
  let(:product_1) { FactoryGirl.create(:product, { user: user }) }

  describe '#index' do
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

  describe '#show' do
    it 'assigns a variable for the product given an id' do
      get :show, params: { id: product.id }
      expect(assigns(:product)).to eq(product)
    end

    it 'renders the show template' do
      get :show, params: { id: product.id }
      expect(response).to render_template(:show)
    end
  end

  describe '#new' do
    before { request.session[:user_id] = user.id }
    it 'assigns an instance variable' do

      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe '#create' do
    before { request.session[:user_id] = user.id }
    context 'with valid attributes' do
      def valid_request
        post :create, params: {
                        product: FactoryGirl.attributes_for(:product)
                      }
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

    context 'with invalid attributes' do
      def invalid_request
        post :create, params: {
                        product: FactoryGirl.attributes_for(:product, title: nil)
                      }
      end
      it 'does not create a product in the database' do
        count_before = Product.count
        invalid_request
        count_after = Product.count
        expect(count_after).to eq(count_before)
      end
      it 'renders the new template' do
        invalid_request
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#edit' do
    before { request.session[:user_id] = user.id }
    it 'assigns a variable for the product given an id' do
      get :edit, params: { id: product.id }
      expect(assigns(:product)).to eq(product)
    end

    it 'renders the edit template' do
      get :edit, params: { id: product.id }
      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    before { request.session[:user_id] = user.id }
    def valid_request(product_id, attributes)
      post :update, params: { id: product_id,
                              product: attributes
                            }
    end
    it 'updates the record in the database' do
      valid_request(product_1.id, { title: 'New Title' })
      product_1.reload
      expect(product_1.title).to eq('New Title')
    end
    it 'does not update the product in the database when given an empty field' do
      date_before = product_1.updated_at
      title_before = product_1.title
      sleep 1
      valid_request(product_1.id, { title: nil })
      product_1.reload
      expect(date_before).to eq(product_1.updated_at)
      expect(title_before).to eq(product_1.title)
    end

  end
end
