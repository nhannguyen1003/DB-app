const express = require("express");
const cartRouter = express.Router();
const authenticate = require("./../middlewares/authentication/index");
const cartController = require("./../controllers/cart/index");

cartRouter.get("/TotalPrice", authenticate, cartController.TotalPrice);

module.exports = cartRouter;