const express = require("express");
const adminRouter = express.Router();
const authenticate = require("./../middlewares/authentication/index");
const adminController = require("../controllers/admin/index");



adminRouter.post("/login", adminController.login);
adminRouter.get("/GetAllCus", authenticate, adminController.getAllCus);

module.exports = adminRouter;
