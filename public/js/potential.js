
function loadMonthYear() {
    const date = new Date();
    let dt = new Date(date.getFullYear(), date.getMonth() - 1, 1);
    $('#cmbMonth').val(dt.getMonth() + 1); // our combo box starts with 1
    $('#cmbYear').val(dt.getFullYear());
    $('#cmbMonth').prop('disabled', true);
    $('#cmbYear').prop('disabled', true);
  }

  loadMonthYear();

function validateMe() {

    isBtnLoaderVisible(true);

    if ($('#cmbMonth').val() === "") {
        alert('Month field is empty');
        $('#cmbMonth').focus();
        return false;
    }

    if ($('#cmbYear').val() === "") {
        alert('Year field is empty');
        $('#cmbYear').focus();
        return false;
    }


    if ($('#iuiTxt').val() === "") {
        alert('Total no. of IUI cycles is empty');
        $('#iuiTxt').focus();
        return false;
    }

    if ($('#ivfTxt').val() === "") {
        alert('Total no. of IVF cycles is empty');
        $('#ivfTxt').focus();
        return false;
    }

    if ($('#freshTxt').val() === "") {
        alert('Fresh pick-ups is empty');
        $('#freshTxt').focus();
        return false;
    }

    if ($('#frozenTxt').val() === "") {
        alert('Frozen Transfers is empty');
        $('#frozenTxt').focus();
        return false;
    }

    if ($('#patientTxt').val() === "") {
        alert('Self (Patient) cycles is empty');
        $('#patientTxt').focus();
        return false;
    }

    if ($('#donotTxt').val() === "") {
        alert('Donor cycles is empty');
        $('#donotTxt').focus();
        return false;
    }

    if ($('#agonistTxt').val() === "") {
        alert('Agonist cycles is empty');
        $('#agonistTxt').focus();
        return false;
    }

    if ($('#antagonistTxt').val() === "") {
        alert('Antagonist cycles is empty');
        $('#antagonistTxt').focus();
        return false;
    }

    let pId = new URLSearchParams(window.location.search).get('pid'),
        iuiTxt = $('#iuiTxt').val(),
        ivfTxt = $('#ivfTxt').val(),
        freshTxt = $('#freshTxt').val(),
        frozenTxt = $('#frozenTxt').val(),
        patientTxt = $('#patientTxt').val(),
        donotTxt = $('#donotTxt').val(),
        agonistTxt = $('#agonistTxt').val(),
        antagonistTxt = $('#antagonistTxt').val();


    let userData = JSON.parse(localStorage.getItem("BSV_IVF_Admin_Data")),
        param = {
            iuiTxt: $('#iuiTxt').val(),
            ivfTxt: $('#ivfTxt').val(),
            freshTxt: $('#freshTxt').val(),
            frozenTxt: $('#frozenTxt').val(),
            patientTxt: $('#patientTxt').val(),
            donotTxt: $('#donotTxt').val(),
            agonistTxt: $('#agonistTxt').val(),
            antagonistTxt: $('#antagonistTxt').val(),
            hospitalId: new URLSearchParams(window.location.search).get('cid'),
            month: parseInt($('#cmbMonth').val()),
            year: parseInt($('#cmbYear').val()),
            empId: parseInt(userData.empId)
        }

    //console.log(param)


    axios
        .post('/center-potentials-add/', param).then((response) => {
            //console.log(response.data[0])
            let res = response.data[0];
            if (res.sucess === 'true') {
                redirect('/hospitals');
                isBtnLoaderVisible(false);
            } else {
                //$('#lblMsg').text(res.msg);
            }
        }).catch((err) => {
            console.log(err);
        });

}

function getPotentialsDetails() {

    isLoaderVisible(true);

    let userData = JSON.parse(localStorage.getItem("BSV_IVF_Admin_Data")), 
    param = {hospitalId:'', empId:''}, 
    urlArr = window.location.href.split('/'),
    empId = urlArr[urlArr.length - 1].slice(-2);

        // param = {
        //     hospitalId: new URLSearchParams(window.location.search).get('cid'),
        //     empId: parseInt(userData.empId)
        // }

    
    console.log(empId);

 
        if(userData.post.toLowerCase() == 'kam') {

            param.hospitalId = new URLSearchParams(window.location.search).get('cid');
            param.empId = parseInt(userData.empId);
  
        } else if(userData.post.toLowerCase() == 'rbm') {
            param.hospitalId = new URLSearchParams(window.location.search).get('cid');
            param.empId = parseInt(empId);
            $('h1').text('Approve Potential');
            document.title = 'Approve Potential';

        } else {
            console.log('');
        }
        

         
    axios
        .post('/center-potentials-details', param).then((response) => {
            console.log(response.data[0])
            if (response.data.length > 0) {
                let res = response.data[0];
                console.log(res);
                $('#iuiTxt').val(res.IUICycle);
                $('#ivfTxt').val(res.IVFCycle);
                $('#freshTxt').val(res.FreshPickUps);
                $('#frozenTxt').val(res.frozenTransfers);
                $('#patientTxt').val(res.SelftCycle);
                $('#donotTxt').val(res.DonorCycles);
                $('#agonistTxt').val(res.AgonistCycles);
                $('#antagonistTxt').val(res.Antagonistcycles);

                let potentialEnteredFor = res.PotentialEnteredFor,
                    arr = potentialEnteredFor.split('-'),
                    year = arr[0],
                    month = arr[1] <= 9 ? parseInt(arr[1].substring(1, 2)) : parseInt(arr[1])
                $('#cmbYear').val(year)
                //$('#cmbMonth').val(month)
                getFirstDayPreviousMonth();
                getFieldData();
            }
            isLoaderVisible(false);

        }).catch((err) => {
            console.log(err);
        });
}

// function showDrNameCentreName() {
//     const urlSearchParams = new URLSearchParams(window.location.search);
//     const params = Object.fromEntries(urlSearchParams.entries());
//     console.log(params);
//     $('#drName').text(params.drName);
//     $('#centreName').text(params.centreName);
// }

function potentialCal(fId, sId, targetElem) {
    
    let firstElem = parseInt($(`#${fId}`).val()), secondElem = parseInt($(`#${sId}`).val()), targetEl = $(`#${targetElem}`);
    targetEl.val(firstElem - secondElem);
    
    if ((firstElem - secondElem) < 0) {        
        if (targetEl.attr('id') == 'freshTxt') {
            alert('Fresh pick can not be negative');            
        } else if (targetEl.attr('id') == 'patientTxt') {
            alert('Self Patient Cycle can not be negative');            
        } else if (targetEl.attr('id') == 'agonistTxt') {
            alert('Agonist Cycles can not be negative');            
        }
    } 
}

$('input').change(function(e) { 
    // potentialCal('ivfTxt', 'freshTxt', 'frozenTxt');
    // potentialCal('ivfTxt', 'patientTxt', 'donotTxt');
    // potentialCal('ivfTxt', 'agonistTxt', 'antagonistTxt');

    potentialCal('ivfTxt', 'frozenTxt', 'freshTxt');
    potentialCal('ivfTxt', 'donotTxt', 'patientTxt');
    potentialCal('ivfTxt', 'antagonistTxt', 'agonistTxt');
});

showDrNameCentreName();
DisabledInput('disabled');

function approveMe() {
    console.log('approved me Clicked');

    let userData = JSON.parse(localStorage.getItem("BSV_IVF_Admin_Data")),
    param = {
        hospitalId: new URLSearchParams(window.location.search).get('cid'),
        rbmId: parseInt(userData.empId),
        kamId: 24, // @TODO THIS NEED TO CHANGE
    }

axios
    .post('/center-potentials-approved', param).then((response) => {
     //   console.log(response.data[0])
        if (response.data.length > 0) {
            let res = response.data[0];
            console.log(res);
            if (res.sucess === 'true')
                {
                    redirect('/hospitals');
                    // @TODO: THIS NEED TO CHANGE
                }
        }

    }).catch((err) => {
        console.log(err);
    });

    return false;
}


function showCheckBoxApproveBtn() {
    let userData = JSON.parse(localStorage.getItem("BSV_IVF_Admin_Data"));
    console.log(userData);

    if(userData.post.toLowerCase() == 'kam') {
        $('.hideApproveChk').hide();
        $('#btnApprove').hide();
    }

    else if(userData.post.toLowerCase() == 'rbm') {
        $('#resetBtn').hide();
        $('#saveBtn').hide();
        $('.two-btn-wrapper').addClass('right');
    }
}

function getFieldData() {
    let iuiTxt = $('#iuiTxt').val(),
    ivfTxt =$('#ivfTxt').val(),
    frozenTxt =$('#frozenTxt').val(),
    freshTxt = $('#freshTxt').val(),
    donotTxt = $('#donotTxt').val(),
    patientTxt = $('#patientTxt').val(),
    antagonistTxt = $('#antagonistTxt').val(),
    agonistTxt = $('#agonistTxt').val();

    console.log('iuiTxt', iuiTxt);
    console.log('ivfTxt', ivfTxt);
    console.log('frozenTxt', frozenTxt);
    console.log('freshTxt', freshTxt);
    console.log('donotTxt', donotTxt);
    console.log('patientTxt', patientTxt);
    console.log('antagonistTxt', antagonistTxt);
    console.log('agonistTxt', agonistTxt);
    window.localStorage.setItem('potentialDetail', JSON.stringify({'iuiTxt': iuiTxt, 'ivfTxt': ivfTxt, 'frozenTxt': frozenTxt, 'freshTxt': freshTxt, 'donotTxt': donotTxt, 'patientTxt': patientTxt, 'antagonistTxt': antagonistTxt, 'antagonistTxt': antagonistTxt, 'agonistTxt': agonistTxt}));
}

function undo() {
    console.log('undo');
    $('#iuiTxt').val(JSON.parse(window.localStorage.getItem('potentialDetail')).iuiTxt),
    $('#ivfTxt').val(JSON.parse(window.localStorage.getItem('potentialDetail')).ivfTxt),
    $('#frozenTxt').val(JSON.parse(window.localStorage.getItem('potentialDetail')).frozenTxt),
    $('#freshTxt').val(JSON.parse(window.localStorage.getItem('potentialDetail')).freshTxt),
    $('#donotTxt').val(JSON.parse(window.localStorage.getItem('potentialDetail')).donotTxt),
    $('#patientTxt').val(JSON.parse(window.localStorage.getItem('potentialDetail')).patientTxt),
    $('#antagonistTxt').val(JSON.parse(window.localStorage.getItem('potentialDetail')).antagonistTxt),
    $('#agonistTxt').val(JSON.parse(window.localStorage.getItem('potentialDetail')).agonistTxt);
}



showCheckBoxApproveBtn();