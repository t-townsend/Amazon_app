class LikesController < ApplicationController
before_action :authenticate_user!

  def create
    # product = Product.find(params[:product_id])
    review = Review.find(params[:review_id])
    like = Like.new(user:current_user, review: review)

    if cannot? :like, review
      redirect_to product_path(review.product), alert: 'Liking your own review is disgusting'
      return
    end

    if like.save
      redirect_to product_path(review.product), notice: "Review Liked!"
    else
      redirect_to product_path(review.product), alert: "Can't Like Review"
    end
  end

  def destroy
    like = Like.find(params[:id])
    review = like.review

    if cannot? :like, like.review
   redirect_to(
     product_path(review.product),
     alert: 'Un-liking your own review is prepostrous ð¤¢'
   )
   return
 end
    if like.destroy
      redirect_to product_path(review.product), notice: "Review UnLinked"
    else
      redirect_to product_path(review.product), alert: like.errors.full_messages
    end
  end
end
