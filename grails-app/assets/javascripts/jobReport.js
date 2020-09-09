
// document ready
$(document).ready(
    function(){
        $.ajax({ cache: false });
        stripe();
        if (navigator.geolocation) {
            //navigator.geolocation.watchPosition(logback);
        } else {
            console.log("Geolocation is not supported by this browser.");
        }

        $("#sig-panel").signaturePanel({
            okCallback: signatureOK,
            cancelCallback: signatureCancel
        });

        $('#chb_calendar').fullCalendar({
            // put your options and callbacks here
            events:"/jobReport/calEvents",
            cache:true
        })

        document.forms.onkeypress = function(e) {
            var key = e.charCode || e.keyCode || 0;
            if (key == 13) {
                e.preventDefault();
            }
        }
    }
);

function handleChange(worker, idx, deleted) {
    if( $(".fieldTeamWorker" + idx).is(':checked')) {
        deleted.val('false');
    }
    else {
        deleted.val('true');
        $(".fieldTeamLeader" + idx).prop("checked", false);
        $(".fieldTeamPayRate" + idx).val("");
        $(".rateTypeEnum" + idx + " option:selected").prop("selected", false);
    }
}

function addJobDetails(){
    var count = workDetailsRowCounter;
    aR( "GET",
        "/workDetails/addRow?count="+count,
        "",
        function(data){
            $('#workDetailsTable').find('tr:last').after(data);
            workDetailsRowCounter++;
        }
    );
}

function addProductRolls(idx){
    var count = window['productRollRowCounter'.concat(idx)];
    console.log("Adding new product roll info with count=" + count);
    aR( "GET",
        "/productInfo/addRow",
        {count:count, idx:idx},
        function(data){
            $('#rollDetailsTable'+idx).find('tr:last').after(data);
            window['productRollRowCounter' + idx]++;
        }
    );
}

function addProducts(){
    console.log("addProducts call with count=" + productsCounter);
    var count = productsCounter;
    aR( "GET",
        "/productInfo/addProduct?count="+count,
        "",
        function(data){
            $('#productListTable').append(data);
            stripe();
            productsCounter++;
        }
    );
}

function aR(type, url, data, success){
    $.ajax( { type: type, url: url, data: data, success: success } );
}

function removeRow(row, deleted){
    row.closest('tr').hide();
    console.log(deleted.val());
    deleted.val(true);
    console.log(deleted.val());
}

function removeTable(tbl, deleted){
    tbl.parent().closest('tr').hide();
    console.log(deleted.val());
    deleted.val(true);
    console.log(deleted.val());
    stripe();
}

function addImageRow(id, tmpl, tbl, type){
    aR( "GET",
        "/siteReport/addRow",
        "id="+ id + "&count=" + window.imageRowCounter + "&tmpl=" + tmpl + "&type=" + type,
        function(data){
            tbl.find('tr:last').after(data);
            window.imageRowCounter = Number.parseInt(window.imageRowCounter) + 1;
            stripe();
        }
    );
}

function addExpenseRow(id, tmpl, tbl, type){
    aR( "GET",
        "/siteReport/addRow",
        "id="+ id + "&count=" + window.expenseRowCounter + "&tmpl=" + tmpl + "&type=" + type,
        function(data){
            tbl.find('tr:last').after(data);
            window.expenseRowCounter = Number.parseInt(window.expenseRowCounter) + 1;
            stripe();
        }
    );
}

function addTimeLogRow(id, tmpl, tbl, type){
    aR( "GET",
        "/siteReport/addRow",
        "id="+ id + "&count=" + window.timeLogRowCounter + "&tmpl=" + tmpl + "&type=" + type,
        function(data){
            tbl.find('tr:last').after(data);
            window.timeLogRowCounter = Number.parseInt(window.timeLogRowCounter) + 1;
            stripe();
        }
    );
}

function addWorkDetailRow(id, counter, tbl, wId){
    var count = Number.parseInt(counter);
    aR( "GET",
        "/siteReport/addWorkDetailRow",
        "id="+ id + "&count=" + window.workDetailsCounter + "&wId=" + wId,
        function(data){
            tbl.find('tr:last').after(data);
            window.workDetailsCounter = Number.parseInt(window.workDetailsCounter) + 1;
            stripe();
        }
    );
}

function addWorkDetail(id){
    // hide the work detail info
    $("#workDetailsInfo").hide();
    // get existing info or new line entry
    aR("GET",
        "/siteReport/addWorkDetail",
        "id="+ id,
        function(data){
            $("#workDetailEntry").html(data).show();
            stripe();
        });
}

function cancelWorkDetails(){
    $("#workDetailEntry").html("").hide();
    $("#workDetailsInfo").show();
}

function updateWorkDetails(){
    var data = $("#workDetailEntry :input").serialize();
    data = data + "&id=" + $("#id").val();
    aR("POST",
        "/siteReport/updateWorkDetails",
        data,
        function(data){
                if (data.status == "success"){
                    $("#workDetailsInfo").html(data.content);
                    cancelWorkDetails();
                }
                else{
                    console.log(data.error);
                }
        });
}

function setRateType(jId, type){
    if($("#fieldTeamWage")) {
        aR("GET",
            "/jobReport/getRateTypeList",
            "id="+ jId + "&wageTypeEnum=" + type,
            function (data) {
                $("#fieldTeamWage").html(data);
            });
    }
}

function getGeoLocation(){
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(setPosition);
    } else {
        console.log("Geolocation is not supported by this browser.");
    }
}

function setPosition(position) {
    window.open("https://www.google.com/maps/?q=" + position.coords.latitude + "," + position.coords.longitude, '_blank');
}

function logback(position){
    console.log("LAT: " + position.coords.latitude + " | Long: " + position.coords.longitude)
}

function setInstallerAccess(jId){
    aR("POST", "/jobReport/installerAccess", "id="+jId, function(data, status, xhr){console.log(status);});
}

function setJobStatus(jId, state){
    aR("POST", "/jobReport/jobStatus", "id="+jId+"&isCompleted="+state, function(data, status, xhr){console.log(status);});
}

function deleteSiteReport(id){
    aR("DELETE", "/siteReport/delete/"+id, "", function(data, status, xhr){location.reload();});
}

function decimalPlaces(f, e, l) {
    var charCode = event.which;
    if(charCode == 8 || charCode == 46 ||(charCode >= 37 && charCode <= 40)){
        return true;
    }
    var number = f.val().split('.');

    // only 1 decimal or comma
    if(number.length>1 && (charCode == 46 || charCode == 188)){
        return false;
    }
    //get the carat position
    var caratPos = getCaretPosition(f.attr('name'));
    var dotPos = f.val().indexOf(".");

    if( caratPos > dotPos && dotPos>-1 && (number[1].length > 1)){
        return false;
    }
    return true;
}

function getCaretPosition(n) {
    var ctrl = document.getElementById(n);
    // IE < 9 Support
    if (document.selection) {
        console.log("document.selection");
        r = document.selection.createTextRage().duplicate();
        r.moveEnd('character', ctrl.value.length);
        if (r.text == '') return ctrl.value.length;
        return ctrl.value.lastIndexOf(r.text)
    }
    // IE >=9 and other browsers
    else if (ctrl.selectionStart || ctrl.selectionStart == '0') {
        return ctrl.selectionStart
    } else {
        return 0;
    }
}

function percentOnly(e){
    var ec = e.which;
    var idx;
    var allowed = ['0','1','2','3','4','5','6','7','8','9','.'];

    idx = $.inArray(String.fromCharCode(ec), allowed);

    if (idx >= 0 || ec == 8 || ec == 9 || ec == 46 || ec == 190) {
        return true
    }

    return false
}

function percentWithNegative(e){
    var ec = e.which;
    var idx;
    var allowed = ['0','1','2','3','4','5','6','7','8','9','.','-'];

    idx = $.inArray(String.fromCharCode(ec), allowed);

    if (idx >= 0 || ec == 8 || ec == 9 || ec == 46 || ec == 109 ||  ec == 189 || ec == 190) {
        return true
    }

    return false
}

function wholeNumbersOnly(e){
    var ec = e.which;
    var allowed;
    var idx;

    allowed = ['0','1','2','3','4','5','6','7','8','9',','];

    idx = $.inArray(String.fromCharCode(ec), allowed);

    if (idx >= 0 || ec == 9) { return true }

    return false
}

function wholeNumbersOnlyNoComma(e){
    var ec = e.which;
    var allowed = ['0','1','2','3','4','5','6','7','8','9'];
    var idx = $.inArray(String.fromCharCode(ec), allowed);
    if (idx >= 0 || ec == 9) { return true }
    return false
}

function formatToLocale(f){
    var n = stripVal(f.val());
    if(f.val().length && $.isNumeric(n)) {
        $.ajax({
            type: "POST",
            url: encodeURI("/utils/formatToLocale"),
            data: "num=" + n,
            success: function (data, status, xhr) {
                //console.log(xhr.status);
                f.val(unescape(data));
            },
            statusCode: {
                401: function () {
                    //pageExpired();
                }
            },
            dataType: "text"
        });
    }
}

// this rather than formatPercent
function formatPercentage(f, d){
    var n = f.val();
    console.log(n);
    if (n) {
        $.ajax({
            type: "POST",
            url: encodeURI("/utils/formatPercentage"),
            data: "num=" + n,
            success: function (data) {
                console.log(data);
                f.val(data);
            },
            statusCode: {
                401: function () {
                    //pageExpired();
                }
            },
            dataType: "text"
        });
    }
}

function stripIt(f){
    var a=f.val();
    a=a.replace(/\,/g,'');
    a=a.replace(/\s/g,'');
    f.val(Number(a));
    return true
}

function stripVal(v){
    var a;
    a=v.replace(/\,/g,'');
    a=a.replace(/\s/g,'');
    return Number(a);
}

function toPct(v){
    return Number(v.replace(/\,/g,'.'))
}

function setLocationAddress(f){
    if(f.prop("checked")){
        $("#jobLocation\\.street").val($("#client\\.address\\.street").val());
        $("#jobLocation\\.city").val($("#client\\.address\\.city").val());
        $("#jobLocation\\.state").val($("#client\\.address\\.state").val());
        $("#jobLocation\\.zipcode").val($("#client\\.address\\.zipcode").val());
    }
    else{
        $("#jobLocation\\.street").val("");
        $("#jobLocation\\.city").val("");
        $("#jobLocation\\.state").val("");
        $("#jobLocation\\.zipcode").val("");
    }
}

function signatureOK(signatureData) {
    $("#clientSignatureString").val(JSON.stringify(signatureData));
    sig_data = signatureData
    // Show the user the signature they've entered.
    $("#my-target").signaturePanel("drawClickstreamToCanvas", signatureData);
    $("#my-panel").signaturePanel("clear");
    signatureCancel();

}

function sigPanelShow(){
    $("#sigPanel").show();
    $("#sigDisplay").hide();
    $('html,body').animate({ scrollTop: $("#sigPanel").offset().top}, 'slow');
}

function signatureCancel() {
    $("#sigPanel").hide();
    signatureShow();
}

function signatureShow(){
    $("#sigDisplay").show();
    drawSig();
}

function drawSig() {
    $("#my-target").signaturePanel("drawClickstreamToCanvas", sig_data);
}

function getReport(){
    var startDate = $("#startDate").val();
    var endDate = $("#endDate").val();
    var url = "/payrollSchedule/excelPayrollStub?startDate=" + startDate + "&endDate=" + endDate;
    window.location.href=encodeURI(url);
}

function setPayrollApproval(sId, state){
    aR("POST", "/jobReport/siteReportStatus", "id="+sId+"&isApprovedForPayroll="+state, function(data, status, xhr){console.log(status);});
}

function saveTeamInfo(){
    var jId = $('input[name="id"]').val();
    aR("POST", "/jobReport/saveTeamInfo", $('#editReport').serialize(), function(data, status, xhr){
        $('#inline').modaal('close');
    });
}

function specialHoursForEmployee(id, event){
    if (id=='null'){
        $(".employeeSpecialHoursList").html('');
        return false
    }
    event.preventDefault();
    this.blur(); // Manually remove focus from clicked link.
    $.get('/payrollSchedule/specialHours?chbEmployee='+id, function(html) {
        $(".employeeSpecialHoursList").html(html);
        stripe();
    });
}

function addSpecialInfoForEmployee() {
    //validate
    if ($("#date").val().length == 0 || $("#typeEnum").children('option:selected').val() == 'null' || $("#hours").val().length == 0 || $("#rate").val().length == 0){
        console.log("Validation Failed!!!");
        if ($("#date").val().length == 0){
            $("#date").addClass("contentframework-required-highlight");
        }
        if ($("#typeEnum").children('option:selected').val() == 'null'){
            $("#typeEnum").addClass("contentframework-required-highlight");
        }
        if ($("#hours").val().length == 0){
            $("#hours").addClass("contentframework-required-highlight");
        }
        if ($("#rate").val().length == 0){
            $("#rate").addClass("contentframework-required-highlight");
        }
        return false;
    }
    else {
        aR("POST", "/payrollSchedule/saveSpecialHours", $('.specialForm :input').serialize(), function (data, status, xhr) {
            $(".employeeSpecialHoursList").html(data);
        });
    }
}

function deleteSpecialHour(id){
    aR("POST", "/payrollSchedule/deleteSpecialHours", "id="+id, function (data, status, xhr) {
        $(".employeeSpecialHoursList").html(data);
    });
}

function priorAdjustmentsForEmployee(id, event){
    if (id=='null'){
        $(".employeePriorAdjustmentList").html('');
        return false
    }
    event.preventDefault();
    this.blur(); // Manually remove focus from clicked link.
    $.get('/payrollSchedule/priorAdjustments?chbEmployee='+id, function(html) {
        $(".employeePriorAdjustmentList").html(html);
        stripe();
    });
}

function addAdjustmentInfoForEmployee() {
    var valid = true;

    if ($("#workDate").val().length == 0){
        console.log("work date");
        $("#workDate").addClass("contentframework-required-highlight");
        valid = false; console.log("Work Date");
    }
    if ($("#jobId").val().length == 0){
        console.log("job id");
        $("#jobId").addClass("contentframework-required-highlight");
        valid = false; console.log("Job ID");
    }
    if ($("#location").val().length == 0){
        console.log("location");
        $("#location").addClass("contentframework-required-highlight");
        valid = false; console.log("Location");
    }
    if ($("#wageTypeEnum").children('option:selected').val() == 'null'){
        console.log("wage type");
        $("#wageTypeEnum").addClass("contentframework-required-highlight");
        valid = false; console.log("Wage Type");
    }
    if ($("#rateTypeEnum").children('option:selected').val() == 'null'){
        console.log("rate type");
        $("#rateTypeEnum").addClass("contentframework-required-highlight");
        valid = false; console.log("Rate Type");
    }
    if ($("#regularHours").val().length == 0){
        console.log("regular hours");
        $("#regularHours").addClass("contentframework-required-highlight");
        valid = false; console.log("Regular Hour");
    }
    if ($("#regularRate").val().length == 0){
        console.log("regular rate");
        $("#regularRate").addClass("contentframework-required-highlight");
        valid = false; console.log("Regular Rate");
    }
    if ($("#regularPay").val().length == 0){
        console.log("regular pay");
        $("#regularPay").addClass("contentframework-required-highlight");
        valid = false; console.log("Regular Pay");
    }
    if ($("#overtimeHours").val().length == 0 && $("#overtimeRate").val().length){
        console.log("overtime hours");
        $("#overtimeHours").addClass("contentframework-required-highlight");
        valid = false; console.log("Overtime Hours");
    }
    if ($("#overtimeRate").val().length == 0 && $("#overtimeHours").val().length){
        console.log("overtime rate");
        $("#overtimeRate").addClass("contentframework-required-highlight");
        valid = false; console.log("Overtime Rate");
    }
    if ($("#overtimePay").val().length == 0 && $("#overtimeHours").val().length && $("#overtimeRate").val().length){
        console.log("overtime pay");
        $("#overtimePay").addClass("contentframework-required-highlight");
        valid = false; console.log("Overtime Pay");
    }

    if (valid){
        aR("POST", "/payrollSchedule/saveAdjustments", $('.priorAdjustmentsForm :input').serialize(), function (data, status, xhr) {
            $(".employeePriorAdjustmentList").html(data);
        });
    }
    else{
        console.log("Validation failed!!!")
        return false;
    }
}

function deletePriorAdj(id){
    aR("POST", "/payrollSchedule/deletePriorAdjustment", "id="+id, function (data, status, xhr) {
        $(".employeePriorAdjustmentList").html(data);
    });
}

function updateTeamComponent(jId){
    aR("POST", "/jobReport/teamStatus", "id="+jId, function (data, status, xhr) {
        $("#teamComponent_"+jId).html(data.content);
        $("#teamComponent_"+jId).attr('title', data.title);
    });
}

function updateRateList(){
    var data = $("#rateClassification :input").serialize();
    aR("POST", "/jobReport/updateRateList", data, function (data, status, xhr) {
        $("#rateClassList").html(data.content);
    });
}

function updateTimesheetHourlyRate(timeSheetId, rate){
    $("#hourlyRateUpdateIndicator_"+timeSheetId).html("");
    var data = "id="+timeSheetId+"&hourlyRate="+rate;
    aR("POST", "/jobReport/updateTimesheetHourlyRate", data, function (data, status, xhr) {
        $("#hourlyRateUpdateIndicator_"+timeSheetId).html(data.statusIndicator);
        $(".hourlyRate_"+timeSheetId).val(data.val);
    });
}

function updatePsfPlfRate(id, field, property){
    $("#statusIndicator_" + property + "_"+id).html("");
    var data = "id=" + id + "&" + field.prop('id') + "=" + field.val();
    console.log(data);
    aR("POST", "/siteReport/updateWorkDetailRate", data, function (data, status, xhr) {
        if (data.status == "success"){ field.val(data.rate); }
        else { field.val(0); }
        $("#statusIndicator_" + property + "_"+id).html(data.statusIndicator);
    });
}