const express = require("express");
const cartRouter = express.Router();
const authenticate = require("./../middlewares/authentication/index");
const cartController = require("./../controllers/cart/index");

cartRouter.get("/TotalPrice", authenticate, cartController.TotalPrice);
cartRouter.get("/getFood", authenticate, cartController.getFood);
cartRouter.get("/getCombo", authenticate, cartController.getCombo);

module.exports = cartRouter;