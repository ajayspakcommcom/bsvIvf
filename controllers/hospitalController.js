const { response } = require('express');
const path = require('path');
const sql = require('mssql');
const dbConfig = require('./config');
const { Console } = require('console');
let _STATUSCODE = 200;


exports.listHospitals = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/hospitals/list.html`);
};

exports.getHospitalDetailsPage = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/hospitals/detail.html`);
};



exports.getHospitalList = (req, res, next) => {
    listHospitalsList(req.body).then((result) => {
        res.status(_STATUSCODE).json(result);
    });
};

exports.getHospitalDetailsById = (req, res, next) => {
    getHospitalDetailsById(req.params).then((result) => {
        res.status(_STATUSCODE).json(result);
    });
};


exports.deleteHospitals = (req, res, next) => {
    deleteHospital(req.body).then(result => {
        console.result;
        res.status(_STATUSCODE).json(result)
    })
};


listHospitalsList = (objParam) => {
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("empId", sql.Int, objParam.empId)
                    .execute("USP_GET_MY_CENTER_LIST")
                    .then(function (resp) {
                        // console.log(resp)
                        resolve(resp.recordset);
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


deleteHospital = (objParam) => {
    // console.log('I am Here', objParam);
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("hospitalId", sql.Int, objParam.hospitalId)
                    .execute("USP_BSVHR_DELETE_HOSPITAL")
                    .then(function (resp) {
                        let json = { success: true, msg: 'Hospital deleted successfully' };
                        resolve(json);
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


exports.addNewHospital = (req, res, next) => {
    let params = Object.assign({ id: null }, req.body);
    updateHospitalDetails(params).then(result => {
        res.status(_STATUSCODE).json(result)
    })
};


exports.updateHospitals = (req, res, next) => {
    let params = Object.assign(req.params, req.body);
    updateHospitalDetails(params).then(result => {
        res.status(_STATUSCODE).json(result)
    })
};

function updateHospitalDetails(objParam) {
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("hospitalId", sql.Int, objParam.hospitalId)
                    .input("name", sql.NVarChar, objParam.hospitalName)
                    .input("regionName", sql.NVarChar, objParam.hospitalregion)
                    .input("isDisabled", sql.Bit, (objParam.isDisabled === 'Checked'))
                    .execute("USP_BSVHR_UPDATE_HOSPITAL_DETAILS_BY_ID")
                    .then(function (resp) {
                        resolve(resp.recordset);
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



getHospitalDetailsById = (objParam) => {
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("hospitalId", sql.Int, objParam.hospitalId)
                    .execute("USP_BSVHR_GET_HOSPITAL_DETAILS_BY_ID")
                    .then(function (resp) {
                        //console.log(resp)
                        resolve(resp.recordset);
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
