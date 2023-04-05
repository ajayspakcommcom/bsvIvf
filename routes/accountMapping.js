const express = require('express');
const router = express.Router();

const controller = require('../controllers/accountMapping');

// router.get('/sku', controller.getSkuList);
// router.post('/add-sku', controller.addUpdateSku);

router.get('/account-mapping/:empID', controller.getAccountMappingPage);
router.get('/account-mapping/potential/:empID', controller.getAccountMappingPotentialDetail);

router.get('/account-mapping/:empId/potential-list', controller.getAccountMappingPotentialList);
router.post('/account-mapping/:empId/potential-list', controller.getAccountMappingPotentialListData);


router.get('/account-mapping/:empId/market-insight-list', controller.getAccountMappingMarketInsightList);
router.post('/account-mapping/:empId/market-insight-list', controller.getAccountMappingMarketInsightListData);


router.get('/account-mapping/:empId/business-list', controller.getAccountMappingBusinessList);
router.post('/account-mapping/:empId/business-list', controller.getAccountMappingBusinessListData);


router.get('/account-mapping/:empId/rate-contract-list', controller.getAccountMappingRateContractList);
router.post('/account-mapping/:empId/rate-contract-list', controller.getAccountMappingRateContractListData);



router.get('/account-mapping/:empId/competition-list', controller.getAccountMappingCompetitiontList);
router.post('/account-mapping/:empId/competition-list', controller.getAccountMappingCompetitionListData);


router.get('/team-report', controller.getTeamReport);




module.exports = router;