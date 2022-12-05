const jwt = require('jsonwebtoken');
const authenticate = (req, res, next) => {
  const token = req.header("token");
  const decode = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);
  if (decode) {
    req.user = decode;
    next();
  } else {
    res.status(404).send("Bạn chưa đăng nhập!");
  }
};

module.exports = authenticate;