const jwt = require("jsonwebtoken");
const Customer = require("./../../models/customer/index");

exports.login = (req, res) => {
  Customer.login(req.body, (result) => {
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

      const user = {
        username: result[0].username,
        FName: result[0].FName,
        MName: result[0].MName,
        LName: result[0].LName,
        BDate: result[0].BDate,
        Email: result[0].Email,
        Age: result[0].Age,
        Gender: result[0].Gender,
      };

      res.send({
        message: "Đăng nhập thành công!",
        token,
        user,
      });
    }
  });
};

exports.info = (req, res) => {
  Customer.info(req.body, (result) => {
    if (result === null) {
      
    }
    else{
        res.send(
          result[0]
        );
    }
  });
};

exports.cart = (req, res) => {
  
};

exports.update = (req, res) => {
  Customer.update(req.params.id, req.body, (result) => {
    if (req.customer.id === req.params.id) {
      if (result === null) {
        res.status(500).send(result);
      } else {
        res.send(result);
      }
    } else {
      res.status(400).send("Không thể cập nhật người dùng này!");
    }
  });
};
// update
