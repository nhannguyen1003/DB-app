const Cart = require("./../../models/cart/index");


exports.TotalPrice = (req, res) => {
    Cart.TotalPrice(req.body, (result) => {
      if (typeof result === "string") {
        res.status(500).send(result);
      } else {
        res.send(result);
      }
    });
  };


exports.getFood = (req, res) => {
  Cart.getFood(req.body, (result) => {
    if (typeof result === "string") {
      res.status(500).send(result);
    } else {
      res.send(result);
    }
  });
};

exports.getCombo = (req, res) => {
  Cart.getCombo(req.body, (result) => {
    if (typeof result === "string") {
      res.status(500).send(result);
    } else {
      res.send(result);
    }
  });
};
