json.id @product.id
json.title @product.title.titleize
json.description @product.description
json.price @product.price
json.sale_price @product.sale_price
json.tags @product.tags do |tag|
  json.name tag.name
end
json.favourites @product.favourites.count
json.seller do
    json.first_name @product.user.first_name
    json.last_name @product.user.last_name
end
json.created_on @product.created_at.strftime('%Y-%B-%d')
json.reviews @product.reviews do |review|
  json.id review.id
  json.body review.body
  json.rating review.rating
  json.reviewer do
      json.first_name review.user.first_name
      json.last_name review.user.last_name
  end
  json.likes review.likes.count
end
