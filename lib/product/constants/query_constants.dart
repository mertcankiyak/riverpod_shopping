const String getProductDetailQuery = r'''
  query getProductDetails($id: ID!) {
    product(id: $id) {
      title
      vendor
      descriptionHtml
      images(first: 5) {
          edges {
            node {
              originalSrc
              altText
            }
          }
        }
      variants(first: 10) {
        edges {
          node {
            id
            title
            sku
            barcode
            availableForSale
            price {
              amount
              currencyCode
            }
            compareAtPrice {
              amount
              currencyCode
            }
            weight
            weightUnit
            selectedOptions {
              name
              value
            }
            image {
              originalSrc
            }
          }
        }
      }
    }
  }
''';

const String getVariantDetailQuery = r'''
  query getVariantDetails($id: ID!) {
    node(id: $id) {
      ... on ProductVariant {
        id
        title
        sku
        barcode
        availableForSale
        price {
          amount
          currencyCode
        }
        compareAtPrice {
          amount
          currencyCode
        }
        weight
        weightUnit
        selectedOptions {
          name
          value
        }
        image {
          originalSrc
          altText
        }
        product {
          title
          vendor
          descriptionHtml
          images(first: 5) {
          edges {
            node {
              originalSrc
              altText
            }
          }
        }
        }
      }
    }
  }
''';

const String createCartQuery = "mutation { cartCreate { cart { id } } }";

const String addToCartMutation = r'''
  mutation addToCart($cartId: ID!, $merchandiseId: ID!) {
    cartLinesAdd(
      cartId: $cartId,
      lines: [
        {
          quantity: 1,
          merchandiseId: $merchandiseId
        }
      ]
    ) {
      cart {
        id
        lines(first: 5) {
          edges {
            node {
              id
              quantity
              merchandise {
                ... on ProductVariant {
                  id
                  title
                }
              }
            }
          }
        }
      }
    }
  }
''';
