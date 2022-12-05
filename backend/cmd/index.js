// Create server http with express js
const express = require("express");
const http = require("http");
const app = express();
const server = http.createServer(app);

// Declare middleware
const bodyParser = require("body-parser");
const cors = require("cors");
const dotenv = require("dotenv");

// Config server
dotenv.config({path: "./../.env"});
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors());

// Root API
let rootRoutes = require("./../routes/index.routes")
app.use("/api/v1", rootRoutes);

server.listen(process.env.SERVER_PORT, () => {
  console.log(
    `server listening on http://${process.env.SERVER_ADDRESS}:${process.env.SERVER_PORT}`
  );
});
