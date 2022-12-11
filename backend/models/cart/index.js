const db = require("../../configs/mysql/index");

var Cart = function (data) {
  this.Combo_Cart = data.Combo_Cart;
  this.Food_Cart = data.Food_Cart;
  this.Total_food = data.Total_food;
  this.Cart_id = data.Cart_id;
  this.Cus_id = data.Cus_id;
};

Cart.TotalPrice = (data, result) => {
  db.query(`select cal_total_price(${data.Cart_id})`, (error, totalPrice) => {
    if (error) {
      //console.log(error);
      result(error.sqlMessage);
    } else {
      //console.log(totalPrice[0]);
      result(totalPrice[0]);
    }
  });
};

Cart.getFood = (data, result) => {
  db.query(`call getCartFood(${data.Cart_id})`, (error, food) => {
    if (error) {
      //console.log(error);
      result(error.sqlMessage);
    } else {
      //console.log(food[0]);
      result(food[0]);
    }
  });
};

Cart.getCombo = (data, result) => {
  db.query(`call getCartFood(${data.Cart_id})`, (error, combo) => {
    if (error) {
      //console.log(error);
      result(error.sqlMessage);
    } else {
      //console.log(combo[0]);
      result(combo[0]);
    }
  });
};


Cart.updateCart = (data, result) => {
  db.query()
};

module.exports = Cart;
