<div>
    <g:render template="jobList" model="${[reportList:jobReportList, isCompleted:false]}"/>
</div>

<div>
    <g:render template="jobList" model="${[reportList:jobsCompletedList, isCompleted:true]}"/>
</div>
<div id="inline" style="display:none;"></div>
<script language="JavaScript">
    function teamConfig(rId, event){
        event.preventDefault();
        this.blur(); // Manually remove focus from clicked link.
        $('#inline').modaal({
            content_source: '#inline',
            after_close:function () {
                location.reload(true);
                //updateTeamComponent(rId);
            }
        });
        $("#inline").html("");
        $.get('/jobReport/quickAccessForTeam?id='+rId, function(html) {
            $("#inline").html(html);
            $("#inline").modaal('open');
        });
    }
</script>