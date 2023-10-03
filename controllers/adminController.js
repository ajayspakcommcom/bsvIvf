const { response } = require('express');
const path = require('path');
const sql = require('mssql');
const dbConfig = require('./config');

const _allowedDesignaiton = ['ADMIN'];

exports.getAdmin = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/admin/login.html`);
};

exports.getDashboard = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/admin/dashboard.html`);
};

exports.postApi = (req, res, next) => {
    //console.log(req.body)
    let _STATUSCODE = 200;
    switch (req.body.method) {
        case 'adminLogin':
            userLogin(req.body).then((result) => {
                let response, success, msg, userDetails, session, statusCode

                if (result.recordset.length > 0) {
                    session = req.session;
                    // console.log(result.recordset);
                    let rec = result.recordset[0];
                    // if (_allowedDesignaiton.includes(rec.Designation.toUpperCase())) {
                    success = true;
                    msg = 'Login successful'
                    userDetails = {
                        empId: rec.EmpID,
                        name: rec.firstName,
                        post: rec.Designation,
                        lastLogin: rec.lastLoginDate,
                        targetLeft: 4
                    }
                    session.userDetails = userDetails;
                    // }
                    // else {
                    //     success = false;
                    //     msg = 'You are not authorized to login to the system';
                    // }
                } else {
                    success = false;
                    msg = 'Invalid username or password';
                }
                response = {
                    success, msg, userDetails
                };
                if (success) {
                    // console.log('send 200')
                    statusCode = _STATUSCODE;
                } else {
                    statusCode = 201;
                }
                res.status(statusCode).json(response);
            })
            break;
        case 'adminData':

            dashboardData(req.body).then((result) => {
                res.status(_STATUSCODE).json(result);
            });
            break;

    }
};


userLogin = (objParam) => {
    console.log('I am Here', objParam);
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("email", sql.NVarChar, objParam.username)
                    .input("password", sql.NVarChar, objParam.password)
                    .input("Ip", sql.NVarChar, objParam.ip)
                    .input("IpLocation", sql.NVarChar, objParam.ipLocation)
                    .execute("USP_VALIDATE_USER")
                    .then(function (resp) {
                        console.log(resp)
                        resolve(resp);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        console.log(err);
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                console.log(err);
            });
    });
};



dashboardData = (objParam) => {
    //    console.log('I am Here', objParam);
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .execute("USP_BSVHR_DASHBOARD")
                    .then(function (resp) {
                        resolve(resp.recordsets);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        //console.log(err);
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                //console.log(err);
            });
    });
};
