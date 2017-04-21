class ReviewsMailer < ApplicationMailer

  def notify_prod_review_owner(review)
    @review = review
    @product = review.product
    @user = @review.user.first_name
    @user2 = @product.user
    mail(to: @user2.email, subject: 'You got a review!') if @user2
  end
end
