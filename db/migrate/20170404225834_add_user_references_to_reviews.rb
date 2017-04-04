class AddUserReferencesToReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :reviews, :reviews, foreign_key: true
  end
end
