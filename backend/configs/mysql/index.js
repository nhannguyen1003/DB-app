const mysql = require('mysql');

var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    port: "3306",
    dialect: "mysql",
    password: 'kimngan1704',
    database: 'food_order',
});

connection.connect((errors) => {
    if (errors) {
        console.log('connection database errors... ', errors.stack);
        return;
    }
    else {
        console.log('connection database sucessful...');
    }
})

module.exports = connection;