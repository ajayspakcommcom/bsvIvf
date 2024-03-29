

function letMeLogin() {

    fetch('https://api.ipify.org/?format=json').then(res => res.json()).then(data => {
        fetch(`https://ipapi.co/${data.ip}/json`).then(resp => resp.json()).then(respData => {
            console.log(respData);



            $('.login-btn-wrapper img').addClass('show');

            if (validateAllInput()) {
                let param = {
                    method: 'adminLogin',
                    username: $('#txtUsername').val(),
                    password: $('#txtPassword').val(),
                    ip: respData.ip,
                    ipLocation: `${respData.city}, ${respData.region}, ${respData.country_name}`
                };
                console.log(param)
                axios
                    .post("/admin/api", param).then((response) => {
                        console.log(response);
                        switch (checkIfValidStatus(response.status)) {
                            case 1:
                                localStorage.setItem("BSV_IVF_Admin_Data", JSON.stringify(response.data.userDetails));

                                let userDesignation = JSON.parse(window.localStorage.getItem('BSV_IVF_Admin_Data')).post;

                                console.log(userDesignation);

                                if (userDesignation.toLowerCase() == 'kam') {
                                    (document.location.href = _URL._POSTLOGINURL);
                                } else if (userDesignation.toLowerCase() == 'admin') {
                                    console.log('Admin');
                                    redirect('/report');
                                }
                                else {
                                    _URL._POSTLOGINURL = '/employees/kam-list';
                                    (document.location.href = _URL._POSTLOGINURL);
                                }

                                break;
                            case 2:
                                $('#lblmsg').text(response.data.msg)
                                break;
                            case 3:
                                $('#lblmsg').text(response.data.msg)
                                break;

                            default:
                                break;
                        }

                        $('.login-btn-wrapper img').removeClass('show');

                    }).catch((err) => {
                        console.log(err);
                    });
            }
        });
    });

}


function getAdminDashboardData() {

    let param = {
        method: 'adminData'
    };
    console.log(param)
    axios
        .post("/admin/api", param).then((response) => {
            console.log(response.data[0][0].TotalEmployees);
            $('#spTotalEmployee').text(response.data[0][0].TotalEmployees)
            $('#spTotalHospitals').text(response.data[1][0].TotalHospitals)

        }).catch((err) => {
            console.log(err);
        });
}

function loadHeader() {
    $('.navigation').load(`${_ROOT}/includes/header.html`);
    $('#right-nav').load(`${_ROOT}/includes/right-nav.html`);
    //$('#header').load(`${_ROOT}/includes/header.html`);
    // $('#header').load('../includes/header.html');
    // $('#header').load('../../includes/header.html');
}

function loadFilter() {
    $('#filterData').load(`${_ROOT}/includes/filter.html`);
}

setTimeout(() => {
    loadHeader();
    loadFilter();
}, 1000);
