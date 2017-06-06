json.array! @products do |product|
  json.id product.id
  json.title product.title
  json.url api_v1_product_url(product)
end
