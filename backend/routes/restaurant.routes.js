const express = require("express");
const restaurantRouter = express.Router();
const userController = require("../controllers/customer/index");

restaurantRouter.post("/login", userController.login);

module.exports = restaurantRouter;
