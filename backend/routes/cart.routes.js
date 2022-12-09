const express = require("express");
const cartRouter = express.Router();
const authenticate = require("../middlewares/authentication/index");
const cartController = require("../controllers/order/index");



cartController.get("/info", authenticate ,cartController.getCart);



module.exports = cartRouter;
