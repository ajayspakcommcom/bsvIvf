

let potentialEnteredData, marketInsightEnteredData, businessEnteredData, competitionEntered;

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
                    <!-- <td>${item.QtyOrdered}</td> -->          
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

            let triggerProtocolData = response.data[0][0], lpsProtocolData = response.data[1][0], gonadotropinslData = response.data[2][0], obstetricsData = response.data[3][0], tableData = response.data[4];

            let arrTriggerData = [], arrLpsData = [], arrGonadotropinsData = [], arrObstetricsData = [], tableHtml = [], totalRow = 0, totalRfshConsumption = 0, totalHmgConsumption = 0, totalProgesteroneConsumption = 0, totalDydrogesteroneConsumption = 0, totalCombinationConsumption = 0,
                totalRhcgConsumption = 0, totalUhcgConsumption = 0, totalAgonistLeuprolideConsumption = 0, totalAgonistTriptorelinConsumption = 0, totalTriptorelinConsumption = 0, totalLeuprolideConsumption = 0;



            // for (let item in triggerProtocolData) {
            //     arrTriggerData.push([item, triggerProtocolData[item]]);
            // }

            // for (let item in lpsProtocolData) {
            //     arrLpsData.push([item, lpsProtocolData[item]]);
            // }

            // for (let item in gonadotropinslData) {
            //     arrGonadotropinsData.push([item, gonadotropinslData[item]]);
            // }

            for (let item in obstetricsData) {
                arrObstetricsData.push([
                    item, obstetricsData[item],
                    Math.floor(Math.random() * 16777215).toString(16)
                ]);
            }

            //console.log(arrGonadotropinsData);

            // google.charts.load('current', { 'packages': ['corechart'] });
            // google.charts.setOnLoadCallback(drawChart);

            // function drawChart() {
            //     renderPieChart('miPieChartTriggerProtocol', 'Trigger Protocol', arrTriggerData);
            //     renderPieChart('miLpsProtocol', 'Luteal Phase Support Protocol', arrLpsData);
            //     renderPieChart('miGonadotropinsProtocol', 'Gonadotropins Protocol', arrGonadotropinsData);
            //     renderBarchar('miBarChart', 'Obstetrics Bar Char', 'Count', 'Obstetrics', arrObstetricsData);
            // }




            for (let item of tableData) {

                totalRow = totalRow + parseFloat(item["IVFCycle"]);
                totalRfshConsumption = totalRfshConsumption + parseFloat(item["RFS CONSUMPTION"]);
                totalHmgConsumption = totalHmgConsumption + parseFloat(item["HMG CONSUMPTION"]);

                totalProgesteroneConsumption = totalProgesteroneConsumption + parseFloat(item["Progesterone CONSUMPTION"]);
                totalDydrogesteroneConsumption = totalDydrogesteroneConsumption + parseFloat(item["Dydrogesterone CONSUMPTION"]);
                totalCombinationConsumption = totalCombinationConsumption + parseFloat(item["Progesretone+Dydrogesterone CONSUMPTION"]);


                totalRhcgConsumption = totalRhcgConsumption + parseFloat(item["R-HCG CONSUMPTION"]);
                totalUhcgConsumption = totalUhcgConsumption + parseFloat(item["U-HCG CONSUMPTION"]);
                totalAgonistLeuprolideConsumption = totalAgonistLeuprolideConsumption + parseFloat(item["Only Agonist-Leuprolide CONSUMPTION"]);
                totalAgonistTriptorelinConsumption = totalAgonistTriptorelinConsumption + parseFloat(item["Only Agonist-Triptorelin CONSUMPTION"]);
                totalTriptorelinConsumption = totalTriptorelinConsumption + parseFloat(item["Dual Trigger (R-HCG + Triptorelin) CONSUMPTION"]);
                totalLeuprolideConsumption = totalLeuprolideConsumption + parseFloat(item["Dual Trigger (R-HCG + Leuprolide) CONSUMPTION"]);


                tableHtml.push(`<tr>
                    <td>${item["IVFCycle"]}</td>
                    <td>${item["answerThreeRFSH"]}</td>
                    <td>${item["RFS CONSUMPTION"]}</td>
                    <td>${item["answerThreeHMG"]}</td>
                    <td>${item["HMG CONSUMPTION"]}</td>
                    <td>${item["answerProgesterone"]}</td>
                    <td>${item["Progesterone CONSUMPTION"]}</td>
                    <td>${item["answerFiveDydrogesterone"]}</td>
                    <td>${item["Dydrogesterone CONSUMPTION"]}</td>
                    <td>${item["answerFiveCombination"]}</td>
                    <td>${item["Progesretone+Dydrogesterone CONSUMPTION"]}</td>
                    <td>${item["answerFourRHCG"]}</td>
                    <td>${item["R-HCG CONSUMPTION"]}</td>
                    <td>${item["answerFourUHCG"]}</td>
                    <td>${item["U-HCG CONSUMPTION"]}</td>
                    <td>${item["answerFourAgonistL"]}</td>
                    <td>${item["Only Agonist-Leuprolide CONSUMPTION"]}</td>
                    <td>${item["answerFourAgonistT"]}</td>
                    <td>${item["Only Agonist-Triptorelin CONSUMPTION"]}</td>
                    <td>${item["answerFourRHCGTriptorelin"]}</td>
                    <td>${item["Dual Trigger (R-HCG + Triptorelin) CONSUMPTION"]}</td>
                    <td>${item["answerFourRHCGLeuprolide"]}</td>
                    <td>${item["Dual Trigger (R-HCG + Leuprolide) CONSUMPTION"]}</td>
                </tr>`);
            }

            // console.log(totalRow);
            // console.log(totalRfshConsumption);
            // console.log(totalHmgConsumption);

            // console.log('==========================');

            // console.log(totalRow);
            // console.log(totalProgesteroneConsumption);
            // console.log(totalDydrogesteroneConsumption);
            // console.log(totalCombinationConsumption);

            // console.log('==========================');

            // console.log(totalRhcgConsumption);
            // console.log(totalUhcgConsumption);
            // console.log(totalAgonistLeuprolideConsumption);
            // console.log(totalAgonistTriptorelinConsumption);
            // console.log(totalTriptorelinConsumption);
            // console.log(totalLeuprolideConsumption);



            arrGonadotropinsData = [['R-FSH', ((totalRfshConsumption / totalRow) * 100)], ['HMG', ((totalHmgConsumption / totalRow) * 100)]];

            arrLpsData = [["Progesterone", ((totalProgesteroneConsumption / totalRow) * 100)], ["Dydrogesterone", ((totalDydrogesteroneConsumption / totalRow) * 100)], ["Combination", ((totalCombinationConsumption / totalRow) * 100)]];

            arrTriggerData = [
                ["RHCG", ((totalRhcgConsumption / totalRow) * 100)],
                ["UHCG", ((totalUhcgConsumption / totalRow) * 100)],
                ["AgonistL", ((totalAgonistLeuprolideConsumption / totalRow) * 100)],
                ["AgonistT", ((totalAgonistTriptorelinConsumption / totalRow) * 100)],
                ["RHCGTriptorelin", ((totalTriptorelinConsumption / totalRow) * 100)],
                ["RHCGLeuprolide", ((totalLeuprolideConsumption / totalRow) * 100)]
            ];

            // console.log(arrTriggerData);

            google.charts.load('current', { 'packages': ['corechart'] });
            google.charts.setOnLoadCallback(drawChart);

            function drawChart() {
                renderPieChart('miPieChartTriggerProtocol', 'Trigger Protocol', arrTriggerData);
                renderPieChart('miLpsProtocol', 'Luteal Phase Support Protocol', arrLpsData);
                renderPieChart('miGonadotropinsProtocol', 'Gonadotropins Protocol', arrGonadotropinsData);
                renderBarchar('miBarChart', 'Obstetrics Bar Char', 'Count', 'Obstetrics', arrObstetricsData);
            }

            $('#miTableReport').html(tableHtml.join(''));
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



    axios
        .post('/foligraf-brand-analysis-report', param).then((response) => {

            let brandList = response.data[0], penCompetitorList = response.data[1], vialCompetitorList = response.data[2], showHtml = [], competitorPenHtml = [], competitorVialHtml = [];

            // console.log('brandList', brandList);
            // console.log('penCompetitorList', penCompetitorList);
            // console.log('vialCompetitorList', vialCompetitorList);

            for (let item of penCompetitorList) {
                competitorPenHtml.push(`
                    <div>
                        <div>Name : <b> ${item.name}</b> Total Business Value : <b>${item.TotalBusinessValue}</b></div>
                    </div>
                `);
            }

            for (let item of vialCompetitorList) {
                competitorVialHtml.push(`
                    <div>
                        <div>Name : <b> ${item.name}</b> Total Business Value : <b>${item.TotalBusinessValue}</b></div>
                    </div>
                `);
            }

            // console.log(competitorPenHtml);
            // console.log(competitorVialHtml);

            for (let item of brandList) {
                showHtml.push(`<tr>
                    <td>${item.name}</td>
                    <td>${item.sumTotalofQty}</td>
                    <td>${item.name.toLowerCase() === 'foligraf pen' ? competitorPenHtml.join('') : competitorVialHtml.join('')}</td>    
                </tr>`);
            }

            $('#brand-competitors-records').html(showHtml.join(''));
            $('.folifraf-analysis-report').addClass('show').removeClass('none');
            isLoaderVisible(false);
        }).catch((err) => {
            console.log(err);
        });

    axios
        .post('/brand-analysis-report', param).then((response) => {
            //console.log('brand-analysis-report', response.data);
            //isLoaderVisible(false);
        }).catch((err) => {
            console.log(err);
        });


    axios
        .post('/brand-consumption-report', param).then((response) => {

            let ivfTotal = 0, foligrafTotal = 0, humogTotal = 0, asporelixTotal = 0, rhcogTotal = 0, agotricTotal = 0, midydrogenTotal = 0, showHtml = [];


            //console.log(response.data[0]);

            for (let item of response.data[0]) {

                ivfTotal = ivfTotal + parseFloat(item['IVF Fresh stimulated Cycles']);
                foligrafTotal = foligrafTotal + parseFloat(item['Foligraf']);
                humogTotal = humogTotal + parseFloat(item['Humog']);
                asporelixTotal = asporelixTotal + parseFloat(item['Asporelix']);
                rhcogTotal = rhcogTotal + parseFloat(item['R-Hucog']);
                agotricTotal = agotricTotal + parseFloat(item['Agotrig']);
                midydrogenTotal = midydrogenTotal + parseFloat(item['Midydrogen']);

                // showHtml.push(`
                // <tr>
                //     <td>${item['IVF Fresh stimulated Cycles']}</td>
                //     <td>${item['Foligraf']}</td>
                //     <td>${item['Humog']}</td>
                //     <td>${item['Asporelix']}</td>
                //     <td>${item['R-Hucog']}</td>
                //     <td>${item['Agotrig']}</td>          
                //     <td>${item['Midydrogen']}</td>          
                // </tr>`
                // );
            }

            showHtml.push(`
                <tr>
                    <td><b>${ivfTotal}</b></td>
                    <td><b>${foligrafTotal}</b></td>
                    <td><b>${humogTotal}</b></td>
                    <td><b>${asporelixTotal}</b></td>
                    <td><b>${rhcogTotal}</b></td>
                    <td><b>${agotricTotal}</b></td>          
                    <td><b>${midydrogenTotal}</b></td>          
                </tr>
                `);


            $('#brand-consumption-records').html(showHtml.join(''));
            $('.brand-consumption-report').addClass('show').removeClass('none');
            isLoaderVisible(false);

        }).catch((err) => {
            console.log(err);
        });


    axios
        .post('/team-progress-report', param).then((response) => {

            console.log(response);

            let showHtml = [], zbmRbmList = response.data[0], potentialEnteredList = response.data[1], marketInsightEnteredList = response.data[3], businessEnteredList = response.data[2], competitionEnteredList = response.data[4];

            potentialEnteredData = potentialEnteredList;
            marketInsightEnteredData = marketInsightEnteredList;
            businessEnteredData = businessEnteredList;
            competitionEntered = competitionEnteredList;

            for (let item of zbmRbmList) {
                showHtml.push(`
                    <tr>
                        <td>${item.ZBM}</td>
                        <td>${item.RBM}</td>
                        <td>${item.FIRSTname}</td>
                        <!--<td>${getTotalHospital(item.empid, potentialEnteredList)}</td>-->
                        <td>${item.TotalHospitalcount}</td>
                        <td>${getTotalPotentialEntered(item.empid, potentialEnteredList, 'potential')}</td>                        
                        <td> <a href="#myModal" class="modal-btn" data-toggle="modal" id="${item.empid}" type="potential"> ${getTotalPotentialNotEntered(item.empid, potentialEnteredList, 'potential')}</a></td>

                        <td>${getTotalPotentialEntered(item.empid, marketInsightEnteredList, 'market-insight')}</td>
                        <td><a href="#myModal" class="modal-btn" data-toggle="modal" data-target="#myModal" id="${item.empid}" type="market-insight"> ${getTotalPotentialNotEntered(item.empid, marketInsightEnteredList, 'market-insight')} </a></td>

                        <td>${getTotalPotentialEntered(item.empid, businessEnteredList, 'business')}</td>
                        <td><a href="#myModal" class="modal-btn" data-toggle="modal" data-target="#myModal" id="${item.empid}" type="business">${getTotalPotentialNotEntered(item.empid, businessEnteredList, 'business')}</a></td>

                        <td>${getTotalPotentialEntered(item.empid, competitionEnteredList, 'competition')}</td>
                        <td><a href="#myModal" class="modal-btn" data-toggle="modal" data-target="#myModal" id="${item.empid}" type="competition">${getTotalPotentialNotEntered(item.empid, competitionEnteredList, 'competition')}</a></td>
                    </tr>
                `);
            }

            $('#progress-progress-report').html(showHtml.join(''));
            $('.progress-report').addClass('show').removeClass('none');
            isLoaderVisible(false);

        }).catch((err) => {
            console.log(err);
        });

    $('.selectedMonth').text($("#monthCombo option:selected").text());

}


$('#progress-progress-report').on('click', '.modal-btn', function () {

    let pendingList = [], showHtml = [], empId = $(this).attr('id');

    // console.log(potentialEnteredData);
    // console.log(marketInsightEnteredData);
    // console.log(businessEnteredData);
    // console.log(competitionEntered);

    console.log(empId);

    if ($(this).attr('type') === 'potential') {
        pendingList = potentialEnteredData.filter(e => (e.empID == empId && e.PotentialedEntered.toLowerCase() === 'no'));
    }

    if ($(this).attr('type') === 'market-insight') {
        pendingList = marketInsightEnteredData.filter(e => (e.empID == empId && e.MarketInsightdEntered.toLowerCase() === 'no'));
    }

    if ($(this).attr('type') === 'business') {
        pendingList = businessEnteredData.filter(e => (e.empID == empId && e.BusinessdEntered.toLowerCase() === 'no'));
    }

    if ($(this).attr('type') === 'competition') {
        pendingList = competitionEntered.filter(e => (e.empID == empId && e.CompEntered.toLowerCase() === 'no'));
    }

    console.log(pendingList);

    for (let item of pendingList) {
        showHtml.push(`
            <tr>
                <td>${item.CENTRENAME == null ? '----' : item.CENTRENAME}</td>
                <td>${item.DoctorName == null ? '----' : item.DoctorName}</td>
            </tr>
        `);
    }

    if (pendingList.length > 0) {
        $('#pending-centre-report').html(showHtml.join(''));
    } else {
        $('#pending-centre-report').html(`
            <tr>
             <td colspan="2"><p class="text-center">No centre found!</p></td>
            </tr>
        `);
    }

});


function getVennReports(e) {

    isLoaderVisible(true);

    let param = {
        empId: _empId,
        month: $('#monthCombo').val(),
        Year: $('#yearCombo').val()
    }

    axios
        .post('/get-brands-under-centers', param).then((response) => {
            console.log(response.data[1]);
            let brands = response.data[0],
                hospitalList = response.data[1];

            let sets = [];
            brands.forEach(brand => {
                sets.push({ sets: [`${brand.brandName} ${brand.CNT}`], size: brand.CNT })
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



