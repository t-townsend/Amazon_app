json.products @products do |product|
  json.id product.id
  json.title product.title
  json.body product.description
  json.price product.price
  json.seller product.user.first_name
  json.category product.category.name
  json.created_on product.created_at.strftime("%Y-%B-%d")



  json.reviews product.reviews do |review|
    json.id review.id
    json.body review.body
    json.rating review.rating
  end

  json.tags product.tags do |tag|
    json.name tag.name
  end
end
