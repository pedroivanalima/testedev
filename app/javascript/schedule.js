window.detail_schedule = function(url){
    $.ajax({
        url: url,
        type: 'get',
        dataType: 'json',
        contentType: 'application/json',
        success: function (data) {
            var schedule = data['schedule'];
            detail_fulfill(schedule.id, schedule.initial_time, schedule.final_time, schedule.description, data['username'])
        }
    });    
}

window.detail_fulfill = function(schedule_id, initial_time, final_time, description, username){
    document.getElementsByName("id")[0].value = schedule_id
    document.getElementsByName("initial_time")[0].value = initial_time;
    document.getElementsByName("final_time")[0].value = final_time;
    document.getElementsByName("description")[0].value = description;
    document.getElementsByName("username")[0].innerText = username;
    
    $("#modal-window").modal();
}

window.detail_submit = function(){
    var schedule_id = document.getElementsByName("id")[0].value;
    var initial_time = document.getElementsByName("initial_time")[0].value;
    var final_time = document.getElementsByName("final_time")[0].value;
    var description = document.getElementsByName("description")[0].value;

    var action = "/schedule"
    if(schedule_id.length > 0){
        action += "/" + schedule_id
    }

    $.ajax({
        url: action,
        type: schedule_id.length == 0 ? "post" : "put",
        dataType: 'json',
        success: function (data) {
            $("#modal-window").modal('hide');
            location.reload();
        },
        error: function(data){
            console.log(data);
            alert(data.responseJSON['msg']);
        },
        data: {
            initial_time: initial_time,
            final_time: final_time,
            description: description,
            id: schedule_id
        }
    })

}

window.remove_schedule = function(id){
    if(confirm("Realmente deseja deletar?")){
        $.ajax({
            url: "/schedule/" + id,
            type: "DELETE",
            success: function(data){
                location.reload();
            },
            error: function(data){
                alert(data.responseJSON['msg'])
            }
        })
    }
    /*else{
        alert("belê");
    }*/
}