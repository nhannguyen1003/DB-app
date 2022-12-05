const db = require("./../../configs/mysql/index");

var Customer = function (data) {
  this.username = data.username;
  this.FName = data.FName;
  this.MName = data.MName;
  this.LName = data.LName;
  this.BDate = data.BDate;
  this.Email = data.Email;
  this.Age = data.Age;
  this.Gender = data.Gender;
};

Customer.login = (data, result) => {
  db.query(
    "select * from Customer join Account on Customer.username = Account.username where Account.username = ? and Account.password = ?",
    [data.username, data.password],
    (error, user) => {
      if (user.length == 0 || error) {
        result(null);
      } else {
        result(user);
      }
    }
  );
};

Customer.info = (data, result) => {
    db.query(
      `call getCustomerInfo('${data.username}')`,
      (error, user) => {
        if (user.length == 0 || error) {
          result(null);
        } else {
          result(user);
        }
      }
    );
};

Customer.cart = (data, result) => {
    db.query(
      "call viewCart( ??)",
      (error, user) => {
        if (user.length == 0 || error) {
          result(null);
        } else {
          result(user);
        }
      }
    );
}

module.exports = Customer;
