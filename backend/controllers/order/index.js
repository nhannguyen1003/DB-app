const Cart = require("./../../models/order/index");


exports.info = (req, res) => {
    Cart.info(req.body, (result) => {
      if (result === null) {
      } else {
        res.send(result[0]);
      }
    });
  };
