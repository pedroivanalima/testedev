window.detail_schedule = function(url){
    $.ajax({
        url: url,
        type: 'get',
        dataType: 'json',
        contentType: 'application/json',
        success: function (data) {
            var schedule = data['schedule'];
            document.getElementsByName("initial_time")[0].value = schedule.initial_time;
            document.getElementsByName("final_time")[0].value = schedule.final_time;
            document.getElementsByName("description")[0].value = schedule.description;
            document.getElementsByName("username")[0].innerText = data['username'];
            $("#modal-window").modal();
        }
    });
}