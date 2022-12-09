const db = require("./../../configs/mysql/index");

var Cart = function (data) {
  this.Combo_Cart = data.Combo_Cart;
  this.Food_Cart = data.Food_Cart;
  this.Total_food = data.Total_food;
  this.Cart_id = data.Cart_id;
  this.Cus_id = data.Cus_id;
};

Cart.info = 

module.exports = Cart;
