
// let designationWiseData = [], _empId = null;

// function getReports() {
//     getDesignationWiseData();
// }

// function getDesignationWiseData() {
//     axios
//         .get('/potential-report-data').then((response) => {
//             designationWiseData = response.data;
//             setDesignationFilters(null, null);
//         }).catch((err) => {
//             console.log(err);
//         });
// }

// //setMonth('monthCombo');

// function setDesignationFilters() {

//     let zbmData = designationWiseData.filter(z => z.Designation.toLowerCase() === 'zbm'), zbmHtml = [],
//         rbmData = designationWiseData.filter(r => r.Designation.toLowerCase() === 'rbm'), rbmHtml = [],
//         kamData = designationWiseData.filter(k => k.Designation.toLowerCase() === 'kam'), kamHtml = [];

//     zbmHtml.push(`<option value="none" selected disabled hidden>Select Zbm</option>`);
//     rbmHtml.push(`<option value="none" selected disabled hidden>Select Rbm</option>`);
//     kamHtml.push(`<option value="none" selected disabled hidden>Select Kam</option>`);

//     for (let item of zbmData) {
//         zbmHtml.push(`<option value="${item.EmpID}">${item.firstName}</option>`);
//     }

//     for (let item of rbmData) {
//         rbmHtml.push(`<option value="${item.EmpID}">${item.firstName}</option>`);
//     }

//     for (let item of kamData) {
//         kamHtml.push(`<option value="${item.EmpID}">${item.firstName}</option>`);
//     }

//     $('#zbmCombo').html(zbmHtml.join(''));
//     $('#rbmCombo').html(rbmHtml.join(''));
//     $('#kamCombo').html(kamHtml.join(''));
// }


// function selectedZbm(event) {
//     let rbmData = designationWiseData.filter(r => r.Designation.toLowerCase() === 'rbm'), rbmHtml = [];
//     rbmData = rbmData.filter(r => r.ParentID == event.target.value);
//     rbmHtml.push(`<option value="none" selected disabled hidden>Select Rbm</option>`);
//     for (let item of rbmData) {
//         rbmHtml.push(`<option value="${item.EmpID}">${item.firstName}</option>`);
//     }
//     $('#rbmCombo').html(rbmHtml.join(''));
//     _empId = event.target.value;
// }

// function selectedRbm(event) {
//     let kamData = designationWiseData.filter(k => k.Designation.toLowerCase() === 'kam'), kamHtml = [];
//     kamData = kamData.filter(k => k.ParentID == event.target.value);
//     kamHtml.push(`<option value="none" selected disabled hidden>Select Kam</option>`);
//     for (let item of kamData) {
//         kamHtml.push(`<option value="${item.EmpID}">${item.firstName}</option>`);
//     }
//     $('#kamCombo').html(kamHtml.join(''));
//     _empId = event.target.value;
// }

// function selectedKam(event) {
//     _empId = event.target.value;
// }

function filterData(e) {
    e.preventDefault();
    isLoaderVisible(true);

    let param = {
        empId: _empId,
        month: $('#monthCombo').val(),
        Year: $('#yearCombo').val()
    }


    axios
        .post('/potential-report-iui-cycle-categary', param).then((response) => {
            let resultGroup = groupByKey(response.data, 'Cycle'), showHtml = [], total = 0;

            for (let key in resultGroup) {
                showHtml.push(`<tr><td>${key}</td> <td>${resultGroup[key].length}</td></tr>`);
                total += parseInt(resultGroup[key].length);
            }
            showHtml.push(`<tr><td>Total</td> <td><b>${total}</b></td></tr>`);
            $('#iuiData').html(showHtml.join(''));
            $('.iui-cycle-report').addClass('show').removeClass('none');
            isLoaderVisible(false);


        }).catch((err) => {
            console.log(err);
        });


    axios
        .post('/potential-report-ivf-cycle-categary', param).then((response) => {
            let resultGroup = groupByKey(response.data, 'Cycle'), showHtml = [], total = 0;

            for (let key in resultGroup) {
                showHtml.push(`<tr><td>${key}</td> <td>${resultGroup[key].length}</td></tr>`);
                total += parseInt(resultGroup[key].length);
            }
            showHtml.push(`<tr><td>Total</td> <td><b>${total}</b></td></tr>`);
            $('#ivfData').html(showHtml.join(''));
            $('.ivf-cycle-report').addClass('show').removeClass('none');
            isLoaderVisible(false);

        }).catch((err) => {
            console.log(err);
        });

    axios
        .post('/hosp-count-brand-wise', param).then((response) => {
            let showHtml = [];

            let total = 0;
            for (let item in response.data[0][0]) {
                total += response.data[0][0][item];
            }

            for (let item of response.data[0]) {
                showHtml.push(`<tr>
                    <td>${item.AGOTRIG}</td>
                    <td>${item.ASPORELIX}</td>
                    <td>${item.FOLICULIN}</td>
                    <td>${item.FOLIGRAF}</td>
                    <td>${item.HUMOG}</td>
                    <td>${item.MIDYDROGEN}</td>
                    <td>${item['R-HUCOG']}</td>
                    <td>${item.SPRIMEO}</td>
                    <td>${`<b>${total}</b> / ${response.data[1][0].totalHospital}`}</td>
                </tr>`);
            }
            $('#hosp-count').html(showHtml.join(''));
            $('.hosp-count-report').addClass('show').removeClass('none');
            isLoaderVisible(false);

        }).catch((err) => {
            console.log(err);
        });


    axios
        .post('/top-15-business-records', param).then((response) => {
            let showHtml = [];
            for (let item of response.data) {
                showHtml.push(`<tr>
                    <td>${item.accountName}</td>
                    <td>${item.CENTRENAME}</td>
                    <td>${item.DoctorName}</td>
                    <td>${item.City}</td>
                    <td>${item.StateName}</td>
                    <td>${item.QtyOrdered}</td>          
                </tr>`);
            }
            $('#top-15-b-records').html(showHtml.join(''));
            $('.top-15-report').addClass('show').removeClass('none');
            isLoaderVisible(false);

        }).catch((err) => {
            console.log(err);
        });


    axios
        .post('/market-insight-data', param).then((response) => {

            let triggerProtocolData = response.data[0][0], lpsProtocolData = response.data[1][0], gonadotropinslData = response.data[2][0], obstetricsData = response.data[3][0];

            let arrTriggerData = [], arrLpsData = [], arrGonadotropinsData = [], arrObstetricsData = [];

            for (let item in triggerProtocolData) {
                arrTriggerData.push([item, triggerProtocolData[item]]);
            }

            for (let item in lpsProtocolData) {
                arrLpsData.push([item, lpsProtocolData[item]]);
            }

            for (let item in gonadotropinslData) {
                arrGonadotropinsData.push([item, gonadotropinslData[item]]);
            }

            for (let item in obstetricsData) {
                arrObstetricsData.push([
                    item, obstetricsData[item],
                    Math.floor(Math.random() * 16777215).toString(16)
                ]);
            }

            google.charts.load('current', { 'packages': ['corechart'] });
            google.charts.setOnLoadCallback(drawChart);

            function drawChart() {
                renderPieChart('miPieChartTriggerProtocol', 'Trigger Protocol', arrTriggerData);
                renderPieChart('miLpsProtocol', 'Luteal Phase Support Protocol', arrLpsData);
                renderPieChart('miGonadotropinsProtocol', 'Gonadotropins Protocol', arrGonadotropinsData);
                renderBarchar('miBarChart', 'Obstetrics Bar Char', 'Count', 'Obstetrics', arrObstetricsData);
            }


            $('.trigger-protocol-report').addClass('show').removeClass('none');
            isLoaderVisible(false);

        }).catch((err) => {
            console.log(err);
        });



    axios
        .post('/potential-report1', param).then((response) => {

            let donorSelfData = response.data[0][0], arrDonorSelfData = [], agonistAntagonistData = response.data[1][0], arrAgonistAntagonistData = [];

            google.charts.load('current', { 'packages': ['corechart'] });
            google.charts.setOnLoadCallback(drawChart);

            for (let item in donorSelfData) {
                arrDonorSelfData.push([item, donorSelfData[item]]);
            }

            for (let item in agonistAntagonistData) {
                arrAgonistAntagonistData.push([item, agonistAntagonistData[item]]);
            }

            function drawChart() {
                renderPieChart('pPieChartDonorSelf', 'Donor Self Cycles', arrDonorSelfData);
                renderPieChart('pPieChartAgonistAntagonist', 'Agonist and Antagonist Cycle', arrAgonistAntagonistData);
            }

            $('.donor-self-report').addClass('show').removeClass('none');
            isLoaderVisible(false);

        }).catch((err) => {
            console.log(err);
        });


    $('.selectedMonth').text($("#monthCombo option:selected").text());

}



function getVennReports(e) {
    
    isLoaderVisible(true);

    let param = {
        empId: _empId,
        month: $('#monthCombo').val(),
        Year: $('#yearCombo').val()
    }


    axios
        .post('/get-brands-under-centers', param).then((response) => {
                //debugger;
                console.log(response.data[1]);
                let brands = response.data[0],
                    hospitalList = response.data[1];
               
               let sets = []; 
                brands.forEach(brand => {
                    sets.push({sets: [`${brand.brandName} ${brand.CNT}`  ], size: brand.CNT})
                });
                console.log(hospitalList);

                // var sets = [
                //     { sets: ['FOLICULIN'], hospitalId: [966, 967] },
                //     { sets: ['HUMOG'], hospitalId: [966, 967] },
                //     { sets: ['FOLIGRAF'], hospitalId: [973] }
                //   ];

                // Set up options
                var options = {
                    width: 500,
                    height: 500
                };
                // Draw the diagram
                var chart = venn.VennDiagram()
                    .width(options.width)
                    .height(options.height);

                d3.select("#venn").datum(sets).call(chart);

        }).catch((err) => {
            console.log(err);
        });


   






    $('.selectedMonth').text($("#monthCombo option:selected").text());

}

