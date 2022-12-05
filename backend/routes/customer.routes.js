const express = require("express");
const customerRouter = express.Router();
const authenticate = require('./../middlewares/authentication/index');
const customerController = require("./../controllers/customer/index");



customerRouter.post("/login", customerController.login); 
customerRouter.get("/info", authenticate, customerController.info);
customerRouter.get("/cart", authenticate, customerController.cart);
customerRouter.put('/update/:id', authenticate, customerController.update);

// customerRouter.post("/register", customerController.register);
// customerRouter.put('/update/:id', authenticate, customerController.update);
// customerRouter.put('/changepw/:id', authenticate, customerController.updatepass);
// customerRouter.get('/customerdetail/:id', authenticate, customerController.getInfo);
// customerRouter.get('/restaurants/:id', customerController.getrestaurants);

module.exports = customerRouter;
