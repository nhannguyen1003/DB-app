const db = require("./../../configs/mysql/index");

var Admin = function (data) {
  this.Admin_id = data.Admin_id;
  this.username = data.username;
  this.password = data.password;
};

Admin.login = (data, result) => {
  db.query(
    "select * from Administration join Account on Administration.username = Account.username where Account.username = ? and Account.password = ?",
    [data.username, data.password],
    (error, user) => {
      if (user.length == 0 || error) {
        console.log(error);
        result(null);
      } else { 
        result(user);
      }
    }
  );
};

Admin.getAllCus = (data, result) => {
  db.query(`call getAllCustomer()`, (error, user) => {
    if (error) {
      result(null);
    } else {
      //console.log(user);
      result(user);
    }
  });
};

module.exports = Admin;
