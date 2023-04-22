
$('#excel').attr('disabled', 'disabled');


function getReports() {
    console.log('Dump Reports');
}


function dumpDataReport(e) {
    e.preventDefault();

    let param = {
        month: $('#monthCombo').val(),
        Year: $('#yearCombo').val()
    }

    potetnialReport(param);
    marketInsightReport(param);
    businessReport(param);
    competitionReport(param);

}

function potetnialReport(param) {
    axios
        .post('/potential-dump-report', param).then((response) => {
            console.log('Potetnial', response.data[0]);
            let showHtml = [];
            for (let item of response.data[0]) {
                showHtml.push(`
                    <tr>
                        <td>${item.ZBM}</td>
                        <td>${item.RBM}</td>
                        <td>${item.KamName}</td>
                        <td>${item.Designation}</td>
                        <td>${item.centreName}</td>
                        <td>${item.DoctorName}</td>
                        <td>${item.customerId}</td>
                        <td>${item.IUICycle}</td>
                        <td>${item.IVFCycle}</td>
                        <td>${item.FreshPickUps}</td>
                        <td>${item.SelftCycle}</td>
                        <td>${item.DonorCycles}</td>
                        <td>${item.AgonistCycles}</td>
                        <td>${item.frozenTransfers}</td>
                        <td>${item.Antagonistcycles}</td>
                        <td>${item.isApproved}</td>
                        <td>${item.ApprovedBy}</td>
                        <td>${item.ApprovedOn}</td>
                        <td>${item.RejectedBy}</td>
                        <td>${item.rejectedOn}</td>
                        <td>${item.rejectComments}</td>
                        <td>${item.PotentialEnteredFor}</td>
                        <td>${item.visiType}</td>
                        <td>${item.RBMStaus}</td>
                    </tr>
                `);
            }

            $('#potential-reports').html(showHtml.join(''));
            $('.potential-dump-report').addClass('show').removeClass('none');

        }).catch((err) => {
            console.log(err);
        });
}

function marketInsightReport(param) {
    axios
        .post('/market-insight-dump-report', param).then((response) => {
            console.log('Market Insight', response.data[0]);
            let showHtml = [];
            for (let item of response.data[0]) {
                showHtml.push(`
                    <tr>
                        <td>${item.ZBM}</td>
                        <td>${item.RBM}</td>
                        <td>${item.KamName}</td>
                        <td>${item.Designation}</td>
                        <td>${item.centreName}</td>
                        <td>${item.DoctorName}</td>
                        <td>${item.customerId}</td>
                        <td>${item['Practice Obstetrics']}</td>
                        <td>${item['Fresh Stimulated Cycles']}</td>
                        <td>${item['RFSH %']}</td>
                        <td>${item['HMG %']}</td>
                        <td>${item['Progesterone %']}</td>
                        <td>${item['Dydrogesterone %']}</td>
                        <td>${item['Combination %']}</td>
                        <td>${item['RHCG %']}</td>
                        <td>${item['UHCG %']}</td>
                        <td>${item['Agonist-Leuprolide %']}</td>
                        <td>${item['Agonist-Triptorelin %']}</td>
                        <td>${item['Dual Trigger (R-HCG + Triptorelin) %']}</td>
                        <td>${item['Dual Trigger (R-HCG + Leuprolide) %']}</td>
                        <td>${item.statusText}</td>
                        <td>${item.ApprovedBy}</td>
                        <td>${item.ApprovedOn}</td>
                        <td>${item.RejectedBy}</td>
                        <td>${item.rejectedOn}</td>
                        <td>${item.rejectComments}</td>
                        <td>${item.addedFor}</td>
                    </tr>
                `);
            }

            $('#market-insight-reports').html(showHtml.join(''));
            $('.market-insight-dump-report').addClass('show').removeClass('none');

        }).catch((err) => {
            console.log(err);
        });
}

function businessReport(param) {
    isLoaderVisible(true);
    axios
        .post('/business-dump-report', param).then((response) => {
            console.log('Business', response.data[0]);
            let showHtml = [];
            for (let item of response.data[0]) {
                showHtml.push(`
                     <tr>
                        <td>${item['ZBM']}</td>
                        <td>${item['RBM']}</td>
                        <td>${item['KamName']}</td>
                        <td>${item['Designation']}</td>
                        <td>${item['CENTRENAME']}</td>
                        <td>${item['DoctorName']}</td>
                        <td>${item['CITY']}</td>
                        <td>${item['hospitalId']}</td>
                        <td>${item['[FOLIGRAF 900 IU/1.5 ML PEN]']}</td>
                        <td>${item['[FOLIGRAF 1200 IU/2 ML PEN] ']}</td>
                        <td>${item['[FOLIGRAF 450 IU/0.75 ML PEN]']}</td>
                        <td>${item['FOLIGRAF PEN']}</td>
                        <td>${item['FOLIGRAF 1200 IU LYO MULTIDOSE']}</td>
                        <td>${item['Foligraf 150 iu']}</td>
                        <td>${item['Foligraf 150 iu PFS']}</td>
                        <td>${item['Foligraf 225 PFS']}</td>
                        <td>${item['Foligraf 300 PFS']}</td>
                        <td>${item['Foligraf 75 iu']}</td>
                        <td>${item['Foligraf 75 iu PFS']}</td>
                        <td>${item['FOLIGRAF (LYO/PFS)']}</td>
                        <td>${item['HP Humog 150 iu']}</td>
                        <td>${item['HP Humog 75 iu']}</td>
                        <td>${item['HuMoG  225 IU BP (Freeze Dried)']}</td>
                        <td>${item['Humog 150 iu']}</td>
                        <td>${item['Humog 75 iu']}</td>
                        <td>${item['HUMOG LYO']}</td>
                        <td>${item['Humog HD 1200 IU Liquid']}</td>
                        <td>${item['Humog HD 600 IU Liquid']}</td>
                        <td>${item['HUMOG LIQ (MD/PFS)']}</td>
                        <td>${item['ASPORELIX']}</td>
                        <td>${item['r – Hucog 6500 i.u. /0.5 ml']}</td>
                        <td>${item['Foliculin 150 iu']}</td>
                        <td>${item['Foliculin 75 iu']}</td>
                        <td>${item['HP Foliculin 150 iu']}</td>
                        <td>${item['HP Foliculin 75 iu']}</td>
                        <td>${item['FOLICULIN']}</td>
                        <td>${item['Agotrig 0.1mg/ml in PFS TFD']}</td>
                        <td>${item['Dydrogesterone 10mg']}</td>
                        <td>${item['SPRIMEO']}</td>
                        <td>${item['isApproved']}</td>
                        <td>${item['accountName']}</td>
                        <td>${item['statusText']}</td>
                        <td>${item['sortOrder']}</td>
                        <td>${item['ApprovedBy']}</td>
                        <td>${item['ApprovedOn']}</td>
                        <td>${item['RejectedBy']}</td>
                        <td>${item['rejectedOn']}</td>
                        <td>${item['ActualEnteredFor']}</td>
                    </tr>
                `);
            }

            $('#business-reports').html(showHtml.join(''));
            $('.business-dump-report').addClass('show').removeClass('none');
            isLoaderVisible(false);
            $('#excel').removeAttr('disabled');

        }).catch((err) => {
            console.log(err);
        });
}

function competitionReport(param) {
    axios
        .post('/competition-dump-report', param).then((response) => {
            console.log('Competition', response.data[0]);
            let showHtml = [];
            for (let item of response.data[0]) {
                showHtml.push(`
                     <tr>
                        <td>${item.ZBM}</td>
                        <td>${item.RBM}</td>
                        <td>${item.KamName}</td>
                        <td>${item.Designation}</td>
                        <td>${item.centreName}</td>
                        <td>${item.DoctorName}</td>
                        <td>${item.centerId}</td>
                        <td>${item.FOLIGRAF}</td>
                        <td>${item.HUMOG}</td>
                        <td>${item.ASPORELIX}</td>
                        <td>${item['R - HUCOG']}</td>
                        <td>${item.FOLICULIN}</td>
                        <td>${item.AGOTRIG}</td>
                        <td>${item.MIDYDROGEN}</td>
                        <td>${item.statusText}</td>
                        <td>${item.ApprovedBy}</td>
                        <td>${item.ApprovedOn}</td>
                        <td>${item.RejectedBy}</td>
                        <td>${item.rejectedOn}</td>
                        <td>${item.competitionAddedFor}</td>
                    </tr>
                `);
            }

            $('#competiton-reports').html(showHtml.join(''));
            $('.competition-dump-report').addClass('show').removeClass('none');
        }).catch((err) => {
            console.log(err);
        });
}

// download xlxs
function downloadReport() {
    let elt = document.getElementById('potentialTable');
    let elt2 = document.getElementById('marketInsightTable');
    let elt3 = document.getElementById('businessTable');
    let elt4 = document.getElementById('competitionTable');

    let ws1 = XLSX.utils.table_to_sheet(elt);
    let ws2 = XLSX.utils.table_to_sheet(elt2);
    let ws3 = XLSX.utils.table_to_sheet(elt3);
    let ws4 = XLSX.utils.table_to_sheet(elt4);

    let wb = XLSX.utils.book_new();

    XLSX.utils.book_append_sheet(wb, ws1, "Potential Report");
    XLSX.utils.book_append_sheet(wb, ws2, "Market Insight Report");
    XLSX.utils.book_append_sheet(wb, ws3, "Business Report");
    XLSX.utils.book_append_sheet(wb, ws4, "Competition Report");

    let wbout = XLSX.write(wb, {
        bookType: 'xlsx',
        bookSST: true,
        type: 'binary'
    });

    function s2ab(s) {
        let buf = new ArrayBuffer(s.length);
        let view = new Uint8Array(buf);
        for (let i = 0; i < s.length; i++) view[i] = s.charCodeAt(i) & 0xFF;
        return buf;
    }

    function downloadXlsx() {
        saveAs(new Blob([s2ab(wbout)], {
            type: "application/octet-stream"
        }), 'reports.xlsx');
    }
    downloadXlsx();
}
// download xlxs


