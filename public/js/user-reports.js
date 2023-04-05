let potentialEnteredData, marketInsightEnteredData, businessEnteredData, competitionEntered;

function getTeamProgressReport() {
    isLoaderVisible(true);
    let userData = JSON.parse(localStorage.getItem("BSV_IVF_Admin_Data")), param;
    const date = new Date();

    param = {
        empId: userData.empId,
        month: date.getMonth(),
        Year: date.getFullYear()
    };

    axios
        .post('/team-progress-report', param).then((response) => {

            let showHtml = [], zbmRbmList = response.data[0], potentialEnteredList = response.data[1], marketInsightEnteredList = response.data[3], businessEnteredList = response.data[2], competitionEnteredList = response.data[4];

            potentialEnteredData = potentialEnteredList;
            marketInsightEnteredData = marketInsightEnteredList;
            businessEnteredData = businessEnteredList;
            competitionEntered = competitionEnteredList;

            for (let item of zbmRbmList) {
                showHtml.push(`
                    <tr>
                        <td>${item.FIRSTname}</td>
                        <td>${getTotalHospital(item.empid, potentialEnteredList)}</td>

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
            isLoaderVisible(false);
        }).catch((err) => {
            console.log(err);
        });
}






$('#progress-progress-report').on('click', '.modal-btn', function () {

    let pendingList = [], showHtml = [], empId = $(this).attr('id');

    // console.log(potentialEnteredData);
    // console.log(marketInsightEnteredData);
    // console.log(businessEnteredData);
    // console.log(competitionEntered);

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




