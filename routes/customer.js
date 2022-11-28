const express = require('express');
const router = express.Router();

const customerController = require('../controllers/customerController');

router.get('/customers', customerController.getCustomerList);
router.get('/add-customer', customerController.addCustomer);
router.post('/add-customer', customerController.addUpdateCustomer);
router.get('/customer/list', customerController.getCustomerListData);
router.post('/customer/delete', customerController.deleteCustomerData);
router.get('/customer-edit/:customerId', customerController.getCustomerDetailsPage);
router.get('/customer-details/:customerId', customerController.getCustomerDetailsById);
router.get('/master-data', customerController.getMasterData);


module.exports = router;