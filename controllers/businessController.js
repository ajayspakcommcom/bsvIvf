const { response } = require('express');
const path = require('path');
const sql = require('mssql');
const url = require('url');
const dbConfig = require('./config');
let _STATUSCODE = 200;

const _allowedDesignaiton = ['ADMIN'];

exports.addBusiness = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/business/add.html`);
};





exports.addUpdateBusinessTracker = (req, res, next) => {
    // console.log('inside update employee');
    let params = Object.assign(req.params, req.body);
    addUpdateBusinessTracker(params).then(result => {
        res.status(_STATUSCODE).json(result)
    })
};



function addUpdateBusinessTracker(objParam) {
    // console.log('--------------------------------')
    // console.log(objParam)
    // console.log('--------------------------------')
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("empId", sql.Int, objParam.empId)
                    .input("hospitalId", sql.Int, parseInt(objParam.hospitalId))
                    .input("Month", sql.Int, objParam.month)
                    .input("Year", sql.Int, objParam.year)
                    .input("brandId", sql.Int, objParam.brandId)
                    .input("brandGroupId", sql.Int, objParam.brandGroupID)
                    .input("skuId", sql.Int, objParam.skuId)
                    .input("rate", sql.Float, parseFloat(objParam.rate))
                    .input("qty", sql.Int, objParam.qty)
                    .input("isContractApplicable", sql.Bit, objParam.isContractApplicable)
                    .execute("USP_add_update_BUSINESS_TRACKER")
                    .then(function (resp) {
                        //  console.log(resp.recordset)
                        resolve(resp.recordset);
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



exports.getSKUDetails = (req, res, next) => {
    // console.log('inside update employee');
    let params = Object.assign(req.params, req.body);
    getSKUDetails(params).then(result => {
        res.status(_STATUSCODE).json(result)
    })
};

function getSKUDetails(objParam) {
    // console.log('--------------------------------')
    // console.log(objParam)
    // console.log('--------------------------------')
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .execute("USP_GET_ALL_SKU_BUSINESS_TRACKER")
                    .then(function (resp) {
                        //console.log(resp.recordset)
                        resolve(resp.recordset);
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


//getBusinessTrackerDetails




exports.getBusinessTrackerDetails = (req, res, next) => {
    // console.log('inside update employee');
    let params = Object.assign(req.params, req.body);
    getBusinessTrackerDetails(params).then(result => {
        res.status(_STATUSCODE).json(result)
    })
};

function getBusinessTrackerDetails(objParam) {
    // console.log('--------------------------------')
    // console.log(objParam)
    // console.log('--------------------------------')
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("customerId", sql.Int, parseInt(objParam.centerId))
                    .input("Month", sql.Int, objParam.month)
                    .input("Year", sql.Int, objParam.year)
                    .execute("USP_GET_BUSINESS_TRACKER_DETAILS")
                    .then(function (resp) {
                        //console.log(resp.recordset)
                        resolve(resp.recordset);
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


//


exports.approveCenterBusinessTracker = (req, res, next) => {
    // console.log('inside update employee');
    let params = Object.assign(req.params, req.body);
    approveCenterBusinessTracker(params).then(result => {
        res.status(_STATUSCODE).json(result)
    })
};

function approveCenterBusinessTracker(objParam) {
    // console.log('--------------------------------')
    // console.log(objParam)
    // console.log('--------------------------------')
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("customerId", sql.Int, parseInt(objParam.centerId))
                    .input("Month", sql.Int, objParam.month)
                    .input("Year", sql.Int, objParam.year)
                    .input("rbmId", sql.Int, objParam.rbmId)
                    .execute("USP_APPROVE_BUSINESS_TRACKER")
                    .then(function (resp) {
                        //console.log(resp.recordset)
                        resolve(resp.recordset);
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


//



exports.approveCenterBusinessTrackerByHospitalId = (req, res, next) => {
    // console.log('inside update employee');
    let params = Object.assign(req.params, req.body);
    approveCenterBusinessTrackerByHospitalId(params).then(result => {
        res.status(_STATUSCODE).json(result)
    })
};

function approveCenterBusinessTrackerByHospitalId(objParam) {
    // console.log('--------------------------------')
    //console.log(objParam)
    // console.log('--------------------------------')
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("customerId", sql.Int, parseInt(objParam.customerId))
                    .input("rbmId", sql.Int, objParam.rbmId)
                    .input("mode", sql.Int, objParam.mode)
                    .input("rejectReason", sql.NVarChar, objParam.rejectReason)
                    .execute("USP_APPROVE_CUSTOMER_BUSINESS_TRACKER_BY_HOSPITALID")
                    .then(function (resp) {
                        //console.log(resp.recordset)
                        resolve(resp.recordset);
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



exports.approveCenteRateContractByCATId = (req, res, next) => {
    const queryObject = url.parse(req.url, true).query;
    let params = Object.assign(req.params, req.body);
    approveCenteRateContractByCATId(params).then(result => {
        res.status(_STATUSCODE).json(result)
    })
};

function approveCenteRateContractByCATId(objParam) {
    console.log('--------------------------------')
    console.log(objParam)
    console.log('--------------------------------')

    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("CATID", sql.Int, parseInt(objParam.CATID))
                    .input("ZbmId", sql.Int, objParam.ZbmId)
                    .execute("USP_APPROVE_CUSTOMER_RATE_CONTRACT_BY_CATID")
                    .then(function (resp) {
                        //console.log(resp.recordset)
                        resolve(resp.recordset);
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