const express = require("express");
const adminRouter = express.Router();
const userController = require("../controllers/customer/index");


adminRouter.post("/login", userController.login);
// adminRouter.get('/customers/:id', authenticate, customerController.getInfo);
// adminRouter.get('/restaurants/:id', customerController.getrestaurants);
module.exports = adminRouter;
