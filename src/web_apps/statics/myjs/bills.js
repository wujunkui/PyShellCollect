
$('#date_select').datepicker();
    //console.log($('#date_select').attr('name'));

//$('#MyTable').datatable({
//    pageSize: 15,
//    sort: '*',
//    option:{"onclick":"test();"}
//});
// $("#MyTable td").attr("onclick","test();")
// $("#MyTable tr td:nth-child(2)").attr("onclick","test();")

function test(){
    $('#test_dialog').dialog();
    }

function eject(id){
    $(id).modal();
}

function ejectDel(data_id) {
    $('#delet').modal();
    $('#sure_button').attr('onclick','deleteData('+data_id+');');
}


function test2(){
    $('#myModal').modal();
}

function insert_data(){
    var new_date = $('#date_select').val();
    var action = $('#action').val();
    var cast = $('#cast').val();
    $.ajax({
    type:"post",
    url:'/bills/upload',
    data:{
        "new_date":new_date,
        "new_action":action,
        "new_cast":cast
    },
    success:function(res){
        location.reload();
    }
    });
}

function update_data(id){
    var input_val = $(id).val();
    console.log(input_val);
}

function deleteData(data_id) {
    $.ajax({
        type:'post',
        url:'/bills/delete',
        data:{
            'id':data_id
        },
        success:function (res) {
            location.reload();
        }
    })
}
