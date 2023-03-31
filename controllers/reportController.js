const { response } = require('express');
const path = require('path');
const sql = require('mssql');
const dbConfig = require('./config');

const _allowedDesignaiton = ['ADMIN'];

exports.customerMasterReport = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/report/customer-master.html`);
};

exports.businessReport = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/report/business.html`);
};

exports.potentialReport = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/report/potential.html`);
};

exports.hospCountBrandWise = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/report/Hospital-count.html`);
};

exports.top15BusinessRecords = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/report/top-15-business-records.html`);
};

exports.rateWithProductReport = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/report/rates-with-products.html`);
};

exports.rcAgreementReport = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/report/rc-agreement.html`);
};

exports.dataReport = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/report/report.html`);
};


exports.dataReportVenn = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/report/businessUnitVenn.html`);
};
// exports.dashboardReport = (req, res, next) => {
//     res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/report/dashboard.html`);
// };

exports.report = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/report/report.html`);
};

exports.dashboardChartReport = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/report/chart.html`);
};

exports.getPotentialData = (req, res, next) => {
    getPotentialData(req.body).then((result) => {
        res.status(200).json(result);
    });
};

exports.getPotentialReport = (req, res, next) => {
    getPotentialReport(req.body).then((result) => {
        res.status(200).json(result);
    });
};

getPotentialReport = (objParam) => {
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .execute("USP_GET_EMPLOYEE_BASED_ON_DESIGNATION")
                    .then(function (resp) {
                        resolve(resp.recordset);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                console.log(err);
            });
    });
};

exports.getPotentialIuiCycleCategory = (req, res, next) => {
    getPotentialIuiCycleCategory(req.body).then((result) => {
        res.status(200).json(result);
    });
};

getPotentialIuiCycleCategory = (objParam) => {
    console.log(objParam);
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("empId", sql.Int, parseInt(objParam.empId))
                    .input("month", sql.Int, parseInt(objParam.month))
                    .input("Year", sql.Int, parseInt(objParam.Year))
                    .execute("USP_IUI_CYCLE_CATEGORY")
                    .then(function (resp) {
                        resolve(resp.recordset);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                console.log(err);
            });
    });
};

exports.getPotentialIvfCycleCategory = (req, res, next) => {
    getPotentialIvfCycleCategory(req.body).then((result) => {
        res.status(200).json(result);
    });
};

getPotentialIvfCycleCategory = (objParam) => {
    console.log(objParam);
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("empId", sql.Int, parseInt(objParam.empId))
                    .input("month", sql.Int, parseInt(objParam.month))
                    .input("Year", sql.Int, parseInt(objParam.Year))
                    .execute("USP_IVF_CYCLE_CATEGORY")
                    .then(function (resp) {
                        resolve(resp.recordset);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                console.log(err);
            });
    });
};

exports.getHospCountBrandWise = (req, res, next) => {
    getHospCountBrandWise(req.body).then((result) => {
        res.status(200).json(result);
    });
};

getHospCountBrandWise = (objParam) => {
    console.log(objParam);
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("empId", sql.Int, parseInt(objParam.empId))
                    .input("month", sql.Int, parseInt(objParam.month))
                    .input("Year", sql.Int, parseInt(objParam.Year))
                    .execute("USP_REPORT_HOSPITALCOUNT_BRANDWISE")
                    //.execute("USP_REPORT_HospitalCount_brandWise")
                    .then(function (resp) {
                        resolve(resp.recordsets);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                console.log(err);
            });
    });
};

exports.getTop15BusinessRecords = (req, res, next) => {
    getTop15BusinessRecords(req.body).then((result) => {
        res.status(200).json(result);
    });
};

getTop15BusinessRecords = (objParam) => {
    console.log(objParam);
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("empId", sql.Int, parseInt(objParam.empId))
                    .input("month", sql.Int, parseInt(objParam.month))
                    .input("Year", sql.Int, parseInt(objParam.Year))
                    .execute("USP_REPORT_TOP_15_ACCOUNTS")
                    .then(function (resp) {
                        resolve(resp.recordset);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                console.log(err);
            });
    });
};

exports.getMarketInsightData = (req, res, next) => {
    getMarketInsightData(req.body).then((result) => {
        res.status(200).json(result);
    });
};

getMarketInsightData = (objParam) => {
    console.log(objParam);
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("empId", sql.Int, parseInt(objParam.empId))
                    .input("month", sql.Int, parseInt(objParam.month))
                    .input("Year", sql.Int, parseInt(objParam.Year))
                    .execute("USP_REPORT_MARKET_INSIGHT")
                    .then(function (resp) {
                        //resolve(resp);
                        resolve(resp.recordsets);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                console.log(err);
            });
    });
};

exports.getPotentialReport1 = (req, res, next) => {
    getPotentialReport1(req.body).then((result) => {
        res.status(200).json(result);
    });
};

getPotentialReport1 = (objParam) => {
    console.log(objParam);
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("empId", sql.Int, parseInt(objParam.empId))
                    .input("month", sql.Int, parseInt(objParam.month))
                    .input("Year", sql.Int, parseInt(objParam.Year))
                    .execute("USP_REPORT_POTENTIALS_V1")
                    .then(function (resp) {
                        resolve(resp.recordsets);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                console.log(err);
            });
    });
};

getPotentialData = (objParam) => {
    //console.log('I am Here', objParam);
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("hospitalId", sql.Int, null)
                    .input("empId", sql.Int, null)
                    .input("startDate", sql.Int, null)
                    .input("endDate", sql.Int, null)
                    .execute("USP_BSVIVF_GET_POTENTIALS")
                    .then(function (resp) {
                        // console.log('***********')
                        // console.log(resp)
                        resolve(resp.recordset);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        // console.log(err);
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                console.log(err);
            });
    });
};


exports.getRateContractData = (req, res, next) => {
    // console.log('i am here');
    getRateContractData(req.body).then((result) => {
        res.status(200).json(result);
    });
};



getRateContractData = (objParam) => {
    //console.log('I am Here', objParam);
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("hospitalId", sql.Int, null)
                    .input("empId", sql.Int, 999)
                    .input("startDate", sql.Int, null)
                    .input("endDate", sql.Int, null)
                    .execute("USP_BSVIVF_REPORT_GET_RCAgreement")
                    .then(function (resp) {
                        // console.log('***********')
                        // console.log(resp)
                        resolve(resp.recordset);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        // console.log(err);
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                console.log(err);
            });
    });
};







exports.getBusinessReport = (req, res, next) => {
    // console.log('i am here');
    getBusinessReport(req.body).then((result) => {
        res.status(200).json(result);
    });
};



getBusinessReport = (objParam) => {
    //console.log('I am Here', objParam);
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("hospitalId", sql.Int, null)
                    .input("empId", sql.Int, 999)
                    .input("startDate", sql.Int, null)
                    .input("endDate", sql.Int, null)
                    .execute("USP_BSVIVF_REPORT_GET_BUSINESS_TRACKER")
                    .then(function (resp) {
                        // console.log('***********')
                        // console.log(resp)
                        resolve(resp.recordset);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        // console.log(err);
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                console.log(err);
            });
    });
};






exports.getAllBusinessReport = (req, res, next) => {
    // console.log('i am here');
    getAllBusinessReport(req.body).then((result) => {
        res.status(200).json(result);
    });
};



getAllBusinessReport = (objParam) => {
    //console.log('I am Here', objParam);
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("hospitalId", sql.Int, null)
                    .input("empId", sql.Int, 999)
                    .input("startDate", sql.Int, null)
                    .input("endDate", sql.Int, null)
                    .execute("USP_BSVIVF_REPORT_GET_BUSINESS_TRACKER_All_reports")
                    .then(function (resp) {
                        // console.log('***********')
                        // console.log(resp)
                        resolve(resp.recordset);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        // console.log(err);
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                console.log(err);
            });
    });
};




exports.getBrandsUnderCenters = (req, res, next) => {
    // console.log('i am here');
    getBrandsUnderCentersData(req.body).then((result) => {
        res.status(200).json(result);
    });
};

getBrandsUnderCentersData = (objParam) => {
    //console.log('I am Here', objParam);
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("empId", sql.Int, null)
                    .input("fromDate", sql.Date, null)
                    .input("toDate", sql.Date, null)
                    .execute("USP_REPORT_BRANDS_VENNDIAGRAM")
                    .then(function (resp) {
                        // console.log('***********')
                        // console.log((resp.recordsets))
                        resolve(resp.recordsets);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        // console.log(err);
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                console.log(err);
            });
    });
};


exports.getFoligrafBrandAnalysis = (req, res, next) => {
    getFoligrafBrandAnalysis(req.body).then((result) => {
        res.status(200).json(result);
    });
};

getFoligrafBrandAnalysis = (objParam) => {
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("empId", sql.Int, null)
                    .input("fromDate", sql.Date, null)
                    .input("toDate", sql.Date, null)
                    .execute("USP_REPORT_BRANDS_FOLIGRAF_ANALYSIS")
                    .then(function (resp) {
                        resolve(resp.recordsets);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        // console.log(err);
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                console.log(err);
            });
    });
};

exports.getBrandAnalysis = (req, res, next) => {
    getBrandAnalysis(req.body).then((result) => {
        res.status(200).json(result);
    });
};

getBrandAnalysis = (objParam) => {
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("empId", sql.Int, null)
                    .input("fromDate", sql.Date, null)
                    .input("toDate", sql.Date, null)
                    .execute("USP_REPORT_BRANDS_ANALYSIS")
                    .then(function (resp) {
                        resolve(resp.recordsets);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        // console.log(err);
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                console.log(err);
            });
    });
};


exports.getBrandConsumptionReport = (req, res, next) => {
    getBrandConsumptionReport(req.body).then((result) => {
        res.status(200).json(result);
    });
};

getBrandConsumptionReport = (objParam) => {
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("empId", sql.Int, parseInt(objParam.empId))
                    .input("month", sql.Int, parseInt(objParam.month))
                    .input("Year", sql.Int, parseInt(objParam.Year))
                    .execute("USP_REPORT_BRANDS_CONSUMPTION")
                    .then(function (resp) {
                        resolve(resp.recordsets);
                        dbConn.close();
                    })
                    .catch(function (err) {
                        // console.log(err);
                        dbConn.close();
                    });
            })
            .catch(function (err) {
                console.log(err);
            });
    });
};


