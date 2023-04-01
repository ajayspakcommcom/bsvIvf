const { response } = require('express');
const path = require('path');
const sql = require('mssql');
const dbConfig = require('./config');
let _STATUSCODE = 200;

exports.addPotential = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/potential/add.html`);
};


exports.addCenterPotential = (req, res, next) => {
    // console.log('inside update employee');
    let params = Object.assign(req.params, req.body);
    addCenterPotential(params).then(result => {
        res.status(_STATUSCODE).json(result)
    })
};


function addCenterPotential(objParam) {
    // console.log('--------------------------------')
    console.log('Potential Added')
    // console.log('--------------------------------')
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("empId", sql.Int, objParam.empId)
                    .input("hospitalId", sql.Int, objParam.hospitalId)
                    .input("IUICycle", sql.Int, objParam.iuiTxt)
                    .input("IVFCycle", sql.Int, (objParam.ivfTxt))
                    .input("FreshPickUps", sql.Int, (objParam.freshTxt))

                    .input("SelftCycle", sql.Int, objParam.patientTxt)
                    .input("DonorCycles", sql.Int, objParam.donotTxt)
                    .input("AgonistCycles", sql.Int, objParam.agonistTxt)
                    .input("frozenTransfers", sql.Int, objParam.frozenTxt)
                    .input("Antagonistcycles", sql.Int, objParam.antagonistTxt)
                    .input("Month", sql.Int, objParam.month)
                    .input("Year", sql.Int, objParam.year)
                    .input("visitID", sql.Int, objParam.visitID)


                    .execute("USP_GET_ADD_UPDATE_CENTER_POTENTIAL")
                    .then(function (resp) {
                        console.log(resp.recordset);
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





exports.getCenterPotentialDetails = (req, res, next) => {
    // console.log('inside update employee');
    let params = Object.assign(req.params, req.body);
    getCenterPotentialDetails(params).then(result => {
        res.status(_STATUSCODE).json(result)
    })
};



function getCenterPotentialDetails(objParam) {
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
                    .input("hospitalId", sql.Int, objParam.hospitalId)
                    .execute("USP_GET_GET_CENTER_POTENTIAL_DETAILS")
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



exports.approveCenterPotential = (req, res, next) => {
    // console.log('inside update employee');
    let params = Object.assign(req.params, req.body);
    approveCenterPotential(params).then(result => {
        res.status(_STATUSCODE).json(result)
    })
};



function approveCenterPotential(objParam) {
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
                    .input("kamId", sql.Int, objParam.kamId)
                    .input("hospitalId", sql.Int, objParam.hospitalId)
                    .input("rbmId", sql.Int, objParam.rbmId)
                    .execute("USP_APPROVE_CUSTOMER_POTENTIALS")
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





exports.approveCenterPotentialByPotentialId = (req, res, next) => {
    // console.log('inside update employee');
    let params = Object.assign(req.params, req.body);
    approveCenterPotentialByPotentialId(params).then(result => {
        res.status(_STATUSCODE).json(result)
    })
};



function approveCenterPotentialByPotentialId(objParam) {
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
                    .input("potentialId", sql.Int, objParam.potentialId)
                    .input("rbmId", sql.Int, objParam.rbmId)
                    .input("mode", sql.Int, objParam.mode)
                    .input("rejectReason", sql.NVarChar, objParam.rejectReason)
                    .execute("USP_APPROVE_CUSTOMER_POTENTIALS_BY_POTENTIALID")
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
