class ReviewsMailer < ApplicationMailer
  def notify_product_owner(review)
    @review = review
    @product = review.product
    @user = @product.user

    mail(to: @user.email, subject: 'You got a review!') if @user
  end
end
