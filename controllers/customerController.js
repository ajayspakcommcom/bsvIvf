const { response } = require('express');
const path = require('path');
const sql = require('mssql');
const dbConfig = require('./config');
let _STATUSCODE = 200;

const _allowedDesignaiton = ['ADMIN'];

exports.getCustomerList = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/customer/list.html`);
};


exports.getCustomerListData = (req, res, next) => {
   // console.log('inside getCustomerListData employee');
     let params = Object.assign(req.params, req.body);
     getCustomerListData(params).then(result => {
         res.status(_STATUSCODE).json(result)
     })
 };


 getCustomerListData = (objParam) => {
    //console.log('I am Here', objParam);
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .execute("USP_GET_CUSTSOMER_LIST")
                    .then(function (resp) {
                       //  console.log(resp)
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



exports.addCustomer = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/customer/add.html`);
};


exports.addUpdateCustomer = (req, res, next) => {
    // console.log('inside update employee');
     let params = Object.assign(req.params, req.body);
     addUpdateCustomer(params).then(result => {
         res.status(_STATUSCODE).json(result)
     })
 };



function addUpdateCustomer( objParam ) {
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
                    .input("customerId", sql.Int, objParam.customerId || null)
                    .input("code", sql.NVarChar, objParam.txtCode)
                    .input("DoctorName", sql.NVarChar, objParam.txtDoctorName)
                    .input("visitId", sql.Int, (objParam.txtVisitCategory))
                    .input("SpecialtyID", sql.Int, (objParam.txtSpecialty))
                    .input("DoctorUniqueCode", sql.NVarChar, objParam.txtDoctorUniqueCode)
                    .input("mobile", sql.NVarChar, objParam.txtMobile)
                    .input("email", sql.NVarChar, objParam.txtEmail)
                    .input("CENTRENAME", sql.NVarChar, objParam.txtCenterName)
                    .input("Address1", sql.NVarChar, (objParam.txtAddress1))
                    .input("Address2", sql.NVarChar, objParam.txtAddress2)
                    .input("LocalArea", sql.NVarChar, objParam.txtLocalArea)
                    .input("City", sql.NVarChar, objParam.txtCity)
                    .input("StateID", sql.Int, objParam.cmbState)
                    .input("PinCode", sql.NVarChar, (objParam.txtPinCode))
                    .input("ChemistMapped", sql.NVarChar, (objParam.txtChemistMapped))
                    .input("isDisabled", sql.Bit, (objParam.chkDisabled))
                    .input("chainID", sql.NVarChar, (objParam.cmbChain))
                    
                    .execute("USP_ADD_UPDATE_CUSTSOMER")
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




exports.deleteCustomerData = (req, res, next) => {
    deleteCustomerData(req.body).then(result => {
        res.status(_STATUSCODE).json(result)
    })
};


deleteCustomerData = (objParam) => {
    // console.log('I am Here', objParam);
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("customerId", sql.Int, objParam.hospitalId)
                    .execute("USP_DELETE_CUSTSOMER")
                    .then(function (resp) {
                        let json = { success: true, msg: 'customer deleted successfully' };
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


exports.getCustomerDetailsPage = (req, res, next) => {
    res.sendFile(`${path.dirname(process.mainModule.filename)}/public/views/customer/add.html`);
};

exports.getCustomerDetailsById = (req, res, next) => {
   // console.log(req.params, '--->')
    getCustomerDetailsById(req.params).then((result) => {
        res.status(_STATUSCODE).json(result);
    });
};


getCustomerDetailsById = (objParam) => {
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .input("customerId", sql.Int, objParam.customerId)
                    .execute("USP_GET_CUSTSOMER_DETAILS_BY_ID")
                    .then(function (resp) {
                    //    console.log(resp)
                        resolve(resp.recordset[0]);
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


//




/************* MASTER MODULE *************/
exports.getMasterData = (req, res, next) => {
    getMasterData(req.params).then((result) => {
        res.status(_STATUSCODE).json(result);
    });
};


getMasterData = (objParam) => {
    return new Promise((resolve) => {
        var dbConn = new sql.ConnectionPool(dbConfig.dataBaseConfig);
        dbConn
            .connect()
            .then(function () {
                var request = new sql.Request(dbConn);
                request
                    .execute("USP_BSV_GET_MASTER_DATA")
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
/************* MASTER MODULE *************/