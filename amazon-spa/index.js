const DOMAIN = "http://localhost:3000"
const API_TOKEN = "k-gI9pPyyHmOjgbsi31lcopdvyIE6fwVjkQzNUOW-wo"

function getProducts (){
  return fetch(`${DOMAIN}/api/v1/products?api_token=${API_TOKEN}`)
  .then(function(res){ return res.json() });
}

function getProduct (id){
  return fetch(`${DOMAIN}/api/v1/products/${id}?api_token=${API_TOKEN}`)
  .then(function (res){ return res.json() });
}

function postReview(reviewParams, productId){
  return fetch(
    `${DOMAIN}/api/v1/products?api_token=${API_TOKEN}`,
    {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({review: reviewParams})
    }
  )
}

function renderProducts(products){
  let temp = Object.values(products);
  const array = [].concat.apply([], temp);
  return array.map(function (product){
    return `
    <div class="product-summary">
        <a
          data-id=${product.id}
          href
          class="question-link">
            ${product.title}
        </a>
      </div>
    `
  }).join('');
}

function renderProduct (product){
  console.log(product);
  return `
  <button class="back">Back</button>
  <h1>${product.title}</h1>
  <p>${product.body}</p>
  <p>${product.price}</p>
  <h4>Reviews</h4>
  <ul class="answers-list">
    ${renderReviews(product.reviews)}
  </ul>
  `
}
function renderReviews(reviews){
  return reviews.map(function (review) {
    return `<li class="review">${review.body}</li>
            <li class="rating">${review.rating}</li>
    `
  }).join('');
}

document.addEventListener('DOMContentLoaded', function (){

  const productsList = document.querySelector('#products-list');
  const productDetails = document.querySelector('#product-details');
  const reviewForm = document.querySelector('#review-form');
  let productId = "";

  function loadProducts() {
    getProducts()
    .then(renderProducts)
    .then(function (html) { productsList.innerHTML = html });

  }

  loadProducts();

  productsList.addEventListener('click', function (event){
    const {target} = event;

    if(target.matches('.question-link')){
      event.preventDefault();
      let productId = target.getAttribute('data-id');

      getProduct(productId)
        .then(function (product){
          productDetails.innerHTML = renderProduct(product);
          productDetails.classList.remove('hidden');
          productsList.classList.add('hidden');
          reviewForm.classList.remove('hidden')
        });
    }
  });


productDetails.addEventListener('click', function (event){
  const {target} = event;

   if(target.matches('button.back')){
     productDetails.classList.add('hidden');
     productDetails.classList.remove('hidden');
     reviewForm.classList.add('hidden');
   }

});

reviewForm.addEventListener('submit', function(event){
  event.preventDefault();


  const body = event.currentTarget.querySelector('#body');
  const rating = event.currentTarget.querySelector('#rating');

  const fData = new FormData(event.currentTarget);

  postReview({ body: fData.get('body'), rating: fData.get('rating')}, productId)
  .then(function () {
    body.value = '';
    rating.value = '';
  });

  getProduct(productId)
    .then(function(product){
      productDetails.innerHTML = renderProduct(product);
    });

})

});













//
