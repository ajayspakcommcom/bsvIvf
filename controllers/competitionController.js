const { response } = require('express');
const path = require('path');
const sql = require('mssql');
const dbConfig = require('./config');
let _STATUSCODE = 200;
const querystring = require('querystring');
const url = require('url');



const _allowedDesignaiton = ['ADMIN'];

exports.addCompetition = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/competition/add.html`);
};





exports.getCompetitionSkusListing = (req, res, next) => {
    // console.log('inside update employee');
    let params = Object.assign(req.params, req.body);
    getCompetitionSkusListing(params).then(result => {
        res.status(_STATUSCODE).json(result)
    })
};

function getCompetitionSkusListing(objParam) {
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
                    .execute("usp_list_competitor_SKUs")
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



exports.addUpdateCompetitionSkus = (req, res, next) => {
    // console.log('inside update employee');
    let params = Object.assign(req.params, req.body);
    addUpdateCompetitionSkus(params).then(result => {
        res.status(_STATUSCODE).json(result)
    })
};



function addUpdateCompetitionSkus(objParam) {
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
                    .input("centerId", sql.Int, parseInt(objParam.centerId))
                    .input("brandId", sql.Int, objParam.brandId)
                    .input("skuId", sql.Int, objParam.skuId)
                    .input("month", sql.Int, parseInt(objParam.month))
                    .input("year", sql.Int, parseInt(objParam.year))
                    .input("value", sql.Float, parseFloat(objParam.value))
                    .input("comments", sql.NText, (objParam.comments))
                    .execute("USP_ADD_UPDATE_SKU_COMPETITION")
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


//


exports.getCompetitionDetailsByCenterId = (req, res, next) => {
    //console.log(req.params, '--->')
    getCompetitionDetailsByCenterId(req.params).then((result) => {
        res.status(_STATUSCODE).json(result);
    });
};


getCompetitionDetailsByCenterId = (objParam) => {
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
                    .input("centerId", sql.Int, objParam.centerId)
                    .input("Month", sql.Int, objParam.month)
                    .input("Year", sql.Int, objParam.year)
                    .execute("USP_GET_SKU_COMPETITION_DETAILS_BY_CENTER")
                    .then(function (resp) {
                        //console.log(resp)
                        resolve(resp.recordset);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        //  console.log(err);
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                //console.log(err);
            });
    });
};


exports.approveCenterCompetition = (req, res, next) => {
    // console.log('inside update employee');

    let params = Object.assign(req.params, req.body);
    approveCenterCompetition(params).then(result => {
        res.status(_STATUSCODE).json(result)
        //console.log(req.params.kamid)
        //res.redirect(`/account-mapping/${req.params.kamid}/competition-list`)
    })
};



function approveCenterCompetition(objParam) {
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
                    .input("hospitalId", sql.Int, objParam.hospitalId)
                    .input("month", sql.Int, objParam.month)
                    .input("year", sql.Int, objParam.year)
                    .input("rbmId", sql.Int, objParam.rbmId)
                    .input("mode", sql.SmallInt, objParam.mode)
                    .input("rejectReason", sql.NVarChar, objParam.rejectReason)

                    .execute("USP_APPROVE_CUSTOMER_COMPETITION")
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
