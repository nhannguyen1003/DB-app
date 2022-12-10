const express = require("express");
const customerRouter = express.Router();
const authenticate = require("./../middlewares/authentication/index");
const customerController = require("./../controllers/customer/index");

customerRouter.post("/login", customerController.login);
customerRouter.get("/info", authenticate, customerController.info);
customerRouter.put("/update", authenticate, customerController.update);
customerRouter.post("/register", customerController.register);
customerRouter.put("/delete/:id", authenticate, customerController.delete);
module.exports = customerRouter;
