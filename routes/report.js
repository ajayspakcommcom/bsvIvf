const express = require('express');
const router = express.Router();

const reportController = require('../controllers/reportController');

router.get('/customer-master-report', reportController.customerMasterReport);
router.get('/business-report', reportController.businessReport);
router.get('/potential-report', reportController.potentialReport);
router.get('/rate-with-product-report', reportController.rateWithProductReport);
router.get('/rc-agreement-report', reportController.rcAgreementReport);
router.get('/dashboard-chart-report', reportController.dashboardChartReport);
router.get('/report', reportController.dataReport);
router.get('/reportVenn', reportController.dataReportVenn);
router.post('/report/potential', reportController.getPotentialData);
router.post('/report/RCAgreement', reportController.getRateContractData);
router.post('/report/businessReport', reportController.getBusinessReport);
router.post('/report/allbusinessReports', reportController.getAllBusinessReport);


//Ajay
// router.get('/report', reportController.potentialReport);
router.get('/potential-report-data', reportController.getPotentialReport);
router.get('/hosp-count-brand-wise', reportController.hospCountBrandWise);
router.get('/top-15-business-records', reportController.top15BusinessRecords);

router.post('/potential-report-iui-cycle-categary', reportController.getPotentialIuiCycleCategory);
router.post('/potential-report-ivf-cycle-categary', reportController.getPotentialIvfCycleCategory);
router.post('/hosp-count-brand-wise', reportController.getHospCountBrandWise);
router.post('/top-15-business-records', reportController.getTop15BusinessRecords);

router.post('/market-insight-data', reportController.getMarketInsightData);

//latest
router.post('/potential-report1', reportController.getPotentialReport1);
router.post('/get-brands-under-centers', reportController.getBrandsUnderCenters);


router.post('/foligraf-brand-analysis-report', reportController.getFoligrafBrandAnalysis);
router.post('/brand-analysis-report', reportController.getBrandAnalysis);

router.post('/brand-consumption-report', reportController.getBrandConsumptionReport);
router.post('/team-progress-report', reportController.getTeamProgressReport);







//Ajay




module.exports = router;