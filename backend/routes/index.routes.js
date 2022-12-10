const express = require("express");
const rootRoutes = express.Router();
const customerRouter = require("./customer.routes");
const restaurantRouter = require("./restaurant.routes");
const adminRouter = require("./admin.routes");
const cartRouter = require("./cart.routes");

rootRoutes.use("/customer", customerRouter);
// rootRoutes.use("/restaurant", restaurantRouter);
rootRoutes.use("/admin", adminRouter);
rootRoutes.use("/Cart", cartRouter);
module.exports = rootRoutes;
