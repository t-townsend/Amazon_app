class ProductsMailer < ApplicationMailer
  def new_product_confirmation(product)
    @product = product
    @user = @product.user
    mail(to: @user.email, subject: "You've created a new product!") if @user
  end
end
