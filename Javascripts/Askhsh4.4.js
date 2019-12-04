var products = [
  {
    "product_name": "Joey",
    "product_img": "\"../Images/80x80/img1.jpg\"",
    "product_price": "10"
  },
  {
    "product_name": "Chandler",
    "product_img": "\"../Images/80x80/img2.jpg\"",
    "product_price": "20"
  },
  {
    "product_name": "Ross",
    "product_img": "\"../Images/80x80/img3.jpg\"",
    "product_price": "15"
  },
  {
    "product_name": "Phoebe",
    "product_img": "\"../Images/80x80/img4.jpg\"",
    "product_price": "12"
  },
  {
    "product_name": "Monica",
    "product_img": "\"../Images/80x80/img5.jpg\"",
    "product_price": "8"
  },
  {
    "product_name": "Rachel",
    "product_img": "\"../Images/80x80/img6.jpg\"",
    "product_price": "10"
  }
];
var cart = [];
var Total = null;
function addProduct() {
  var product_name = document.getElementById("product_name").value;
  var product_img = document.getElementById("product_img").value;
  var price = document.getElementById("price").value;

  var newProduct = {
    product_name: null,
    product_img: null,
    product_price: 0.00,
  };
  newProduct.product_name = product_name;
  newProduct.product_img = product_img;
  newProduct.product_price = price;
  products.push(newProduct);
  var table = "<table border='1' >";
  table += "<td>Product Name</td>";
  table += "<td class=\"prodimage\">Product Image</td>";
  table += "<td>Price</td>";
  table += "<td>Action</td>";
  for (var i = 0; i < products.length - 1; i++) {
    table += "<tr>";
    table += "<td>" + products[i].product_name + "</td>";
    table += "<td class=\"prodimage\"><img src=" + products[i].product_img + "></td>"; ////
    table += "<td style=\"text-align: center\">" + products[i].product_price + "</td>";
    table += "<td style=\"text-align: center\"><button type='submit' onClick='deleteProd(\"" + products[i].product_name + "\", this);'/>Delete Item</button> &nbsp <button type='submit' onClick='addtoCart(\"" + products[i].product_name + "\", this);'/>Add to Cart</button></td>";
    table += "</tr>";
  }
  table += "</table>";
  document.getElementById("demo").innerHTML = table;
  document.getElementById("btnAddProduct").remove();
}

function deleteProd(product_name, a) {
  a.parentNode.parentNode.parentNode.removeChild(a.parentNode.parentNode);
  for (var i = 0; i < products.length; i++) {
    if (products[i].product_name == product_name) {
      products.splice(i, 1);
    }
  }
}

function deleteProdCart(product_name, a) {
  a.parentNode.parentNode.parentNode.removeChild(a.parentNode.parentNode);
  for (var i = 0; i < cart.length; i++) {
    if (cart[i].product.product_name == product_name) {
      Total -= parseFloat(cart[i].product.product_price);
      document.getElementById('demo3').innerHTML = Total;
      cart.splice(i, 1);
    }
  }
}

function addtoCart(product_name) {
  for (var i = 0; i < products.length; i++) {
    if (products[i].product_name == product_name) {
      var cartItem = null;
      for (var k = 0; k < cart.length; k++) {
        if (cart[k].product.product_name == products[i].product_name) {
          cartItem = cart[k];
          break;
        }
      }
      if (cartItem == null) {
        var cartItem = {
          product: products[i],
        };
        cart.push(cartItem);
      }
    }
  }
  renderCartTable();
}

function renderCartTable() {
  var table = '';
  var ele = document.getElementById("demo2");
  ele.innerHTML = '';
  table += "<table id='tblCart' border='1'>";
  table += "<tr><td>Product Name</td>";
  table += "<td class=\"prodimage\">Product Image</td>";
  table += "<td>Price</td>";
  table += "<td>Total(with discount)</td>";
  table += "<td>Action</td></tr>";
  Total = 0;
  for (var i = 0; i < cart.length; i++) {
    table += "<tr>";
    table += "<td>" + cart[i].product.product_name + "</td>";
    table += "<td class=\"prodimage\"><img src=" + cart[i].product.product_img + "></td>"; ////
    table += "<td style=\"text-align: center\">" + cart[i].product.product_price + "</td>";
    table += "<td style=\"text-align: center\">" + parseFloat(cart[i].product.product_price) + "</td>";
    table += "<td><button type='submit' onClick='deleteProdCart(\"" + cart[i].product.product_name + "\", this);'/>Delete Item</button> &nbsp </td>";
    table += "</tr>";
    Total += parseFloat(cart[i].product.product_price);
  }
  document.getElementById('demo3').innerHTML = Total;
  table += "</table>";
  ele.innerHTML = table;
}

function removeItem(product_name) {
  for (var i = 0; i < cart.length; i++) {
    if (cart[i].product.product_name == product_name) {
      cart.splice(i, 1);
    }
  }
  renderCartTable();
}
