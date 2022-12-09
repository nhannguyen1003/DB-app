const jwt = require("jsonwebtoken");
const Admin = require("./../../models/admin/index");

exports.login = (req, res) => {
  Admin.login(req.body, (result) => {
    if (result === null) {
      res.status(500).send("Đăng nhập sai tài khoản hoặc mật khẩu!");
    } else {
      const token = jwt.sign(
        {
          username: result[0].username,
        },
        process.env.ACCESS_TOKEN_SECRET,
        { expiresIn: "1h" }
      );

      res.send({
        message: "Đăng nhập thành công!",
        token,
      });
    }
  });
};

exports.getAllCus = (req, res) => {
  Admin.getAllCus(req.body, (result) => {
    if (result === null) {
    } else {
      res.send(result[0]);
    }
  });
};

// update
