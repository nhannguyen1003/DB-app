const Cart = require("./../../models/cart/index");


exports.TotalPrice = (req, res) => {
    Cart.TotalPrice(req.body, (result) => {
      if (result === null) {
      } else {
        res.send(result);
      }
    });
  };
