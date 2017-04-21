class ProductsMailer < ApplicationMailer

  def notify_product_owner(product)
    @product = product
    @category = product.category
    @user = @product.user
    mail(to: @user.email, subject: 'You created a product!')if @user
  end
end
