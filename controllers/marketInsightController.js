const { response } = require('express');
const path = require('path');
const sql = require('mssql');
const dbConfig = require('./config');
let _STATUSCODE = 200;
const _allowedDesignaiton = ['ADMIN'];

exports.addMarketInsight = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/market-insight/add.html`);
};


exports.addCenterMarketInsight = (req, res, next) => {
    let params = Object.assign(req.params, req.body);
    addCenterMarketInsight(params).then(result => {
        res.status(_STATUSCODE).json(result)
    })
};


function addCenterMarketInsight(objParam) {
    // console.log('--------------------------------')
    console.log('Insight Added Added')
    // console.log('--------------------------------')
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("insightId", sql.Int, objParam.insightId || null)
                    .input("empId", sql.Int, objParam.empId)
                    .input("centreId", sql.Int, objParam.centreId)
                    .input("month", sql.Int, objParam.month)
                    .input("year", sql.Int, objParam.year)
                    .input("answerOne", sql.Bit, (objParam.answerOne))

                    .input("AnswerTwo", sql.NVarChar, (objParam.AnswerTwo))
                    .input("answerThreeRFSH", sql.NVarChar, (objParam.answerThreeRFSH))
                    .input("answerThreeHMG", sql.NVarChar, (objParam.answerThreeHMG))
                    .input("answerFourRHCG", sql.NVarChar, (objParam.answerFourRHCG))

                    .input("answerFourAgonistL", sql.NVarChar, (objParam.answerFourAgonistL))
                    .input("answerFourAgonistT", sql.NVarChar, (objParam.answerFourAgonistT))
                    .input("answerFourRHCGTriptorelin", sql.NVarChar, (objParam.answerFourRHCGTriptorelin))
                    .input("answerFourRHCGLeuprolide", sql.NVarChar, (objParam.answerFourRHCGLeuprolide))
                    .input("answerProgesterone", sql.NVarChar, (objParam.answerProgesterone))
                    .input("answerFiveDydrogesterone", sql.NVarChar, (objParam.answerFiveDydrogesterone))
                    .input("answerFiveCombination", sql.NVarChar, (objParam.answerFiveCombination))
                    .input("answerFourUHCG", sql.NVarChar, (objParam.answerFourUHCG))

                    .execute("USP_ADD_UPDATE_MARKET_INSIGHT_BY_KAM")
                    .then(function (resp) {
                        console.log('success');
                        resolve(resp.recordset);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        console.log('error');
                        console.log(err);
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                console.log(err);
            });
    });
};


exports.getCenterMarketInsightById = (req, res, next) => {
    console.log(req.params, '--->')
    getCenterMarketInsightById(req.params).then((result) => {
        res.status(_STATUSCODE).json(result);
    });
};


getCenterMarketInsightById = (objParam) => {
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("insightId", sql.Int, objParam.insightId == 'null' ? null : objParam.insightId)
                    .input("centerId", sql.Int, objParam.centerId)
                    .execute("USP_LIST_MARKET_INSIGHT_BY_INSIGHTID")
                    .then(function (resp) {
                        resolve(resp.recordsets);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        console.log(err);
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                //console.log(err);
            });
    });
};

exports.approveCenterMarketInsightByInsightId = (req, res, next) => {
    // console.log('inside update employee');
    let params = Object.assign(req.params, req.body);
    approveCenterMarketInsightByInsightId(params).then(result => {
        res.status(_STATUSCODE).json(result)
    })
};


function approveCenterMarketInsightByInsightId(objParam) {
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
                    .input("insightId", sql.Int, objParam.insightId)
                    .input("rbmId", sql.Int, objParam.rbmId)
                    .input("mode", sql.Int, objParam.mode)
                    .input("rejectReason", sql.NVarChar, objParam.rejectReason)
                    .execute("USP_APPROVE_CUSTOMER_MARKET_INSIGHT_BY_RBM")
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

