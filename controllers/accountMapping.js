const { response } = require('express');
const path = require('path');
const sql = require('mssql');
const dbConfig = require('./config');
let _STATUSCODE = 200;
const _allowedDesignaiton = ['ADMIN'];

exports.getAccountMappingPage = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/account-mapping/index.html`);
};


exports.getAccountMappingPotentialList = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/account-mapping/potential-list.html`);
};

exports.getAccountMappingMarketInsightList = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/account-mapping/market-insight.html`);
};


exports.getAccountMappingBusinessList = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/account-mapping/business-list.html`);
};

exports.getAccountMappingPotentialDetail = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/account-mapping/view-potential.html`);
};


//getAccountMappingPotentialListData

exports.getAccountMappingPotentialListData = (req, res, next) => {
    // console.clear();
    //  console.log(req.session.userDetails.post, '--->')
    let spName = 'USP_GET_RBM_POTENTIAL_LIST_FOR_APPROVAL'
    if (req.session.userDetails && req.session.userDetails.post === 'ZBM') {
        spName = 'USP_GET_ZBM_POTENTIAL_LIST_FOR_APPROVAL'
    }
    getAccountMappingPotentialListData(req.params, spName).then((result) => {
        res.status(_STATUSCODE).json(result);
    });
};


getAccountMappingPotentialListData = (objParam, storeProc) => {
    // console.clear();
    // console.log('Ram', objParam.empId);
    // console.log(storeProc)
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("KamId", sql.Int, objParam.empId)
                    .execute(storeProc)
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

exports.getAccountMappingMarketInsightListData = (req, res, next) => {
    // console.clear();
    // console.log(req.session.userDetails.post, '--->')
    let spName = 'USP_GET_RBM_MarketInsights_LIST_FOR_APPROVAL'
    if (req.session.userDetails && req.session.userDetails.post === 'ZBM') {
        spName = 'USP_GET_ZBM_MarketInsights_LIST_FOR_APPROVAL'
    }
    getAccountMappingMarketInsightListData(req.params, spName).then((result) => {
        res.status(_STATUSCODE).json(result);
    });
};

getAccountMappingMarketInsightListData = (objParam, storeProc) => {
    //console.log(storeProc)
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("KamId", sql.Int, objParam.empId)
                    .execute(storeProc)
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


exports.getAccountMappingBusinessListData = (req, res, next) => {
    // console.log(req.params, '--->')
    //  console.log(req.session.userDetails.post, '--->')
    let spName = 'USP_GET_RBM_BUSINESS_LIST_FOR_APPROVAL'
    if (req.session.userDetails && req.session.userDetails.post === 'ZBM') {
        spName = 'USP_GET_ZBM_BUSINESS_LIST_FOR_APPROVAL'
    }
    getAccountMappingBusinessListData(req.params, spName).then((result) => {
        res.status(_STATUSCODE).json(result);
    });
};


getAccountMappingBusinessListData = (objParam, storeProc) => {
    //console.log(storeProc)
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("KamId", sql.Int, objParam.empId)
                    .execute(storeProc)
                    .then(function (resp) {
                        //console.log(resp)
                        resolve(resp.recordsets);
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





exports.getAccountMappingRateContractList = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/account-mapping/rate-contract-list.html`);
};


exports.getAccountMappingRateContractListData = (req, res, next) => {
    // console.log(req.params, '--->')
    getAccountMappingRateContractListData(req.params).then((result) => {
        res.status(_STATUSCODE).json(result);
    });
};


getAccountMappingRateContractListData = (objParam) => {
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("parentID", sql.Int, objParam.empId)
                    .execute("USP_GET_ZBM_RATE_CONTRACT_LIST_FOR_APPROVAL")
                    .then(function (resp) {
                        //console.log(resp)
                        resolve(resp.recordsets);
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



exports.getAccountMappingCompetitiontList = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/account-mapping/competition-list.html`);
};





exports.getAccountMappingCompetitionListData = (req, res, next) => {
    // console.log(req.params, '--->')
    // console.log(req.session.userDetails, '--->')
    let spName = 'USP_GET_COMPETITION_LIST_FOR_RBM'
    if (req.session.userDetails && req.session.userDetails.post === 'ZBM') {
        spName = 'USP_GET_COMPETITION_LIST_FOR_ZBM'
    }
    getAccountMappingCompetitionListData(req.params, spName).then((result) => {
        res.status(_STATUSCODE).json(result);
    });
};


getAccountMappingCompetitionListData = (objParam, storeProc) => {
    //console.log(objParam, '--->')

    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("KamId", sql.Int, objParam.empId)
                    .execute(storeProc)
                    .then(function (resp) {
                        //console.log(resp)
                        resolve(resp.recordsets);
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

