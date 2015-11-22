// Getting places list
var editLabel;
var emptyLabel;

function setEditLabel(label){
    editLabel = label;
}

function setEmptyLabel(label){
    emptyLabel = label;
}

function getPlacesFromController(controller, tableID){
    $.ajax({
        url: controller,
        dataType: 'json',
        data: {
            name : $(".admin-findPlace-form input[name='name']").val(),
            town : $(".admin-findPlace-form input[name='town']").val(),
            address : $(".admin-findPlace-form input[name='address']").val()
        },
        success: function(data) {
            updateTable(createTableWithPlaces(data), tableID);
        },
        error: function(request, status, error) {
            alert(error)
        },
        complete: function() {
        }
    });
}

function createTableWithPlaces(data){
    var tableBody = "";
    data.forEach(function(element, index, array){
        tableBody = tableBody +
            "<tr>"+
            // name column
            "<td class='col-md-3 col-sm-3 col-xs-3'>" +
            "<a href='/place/show/" + element["id"] + "'>" +
                element["name"] +
            "</a>" +
                "<div class='pull-right'>" +
                "<a href='/place/edit/"+ element["id"] + "'>" +
                "<span class='glyphicon glyphicon-edit'></span> " +
                editLabel + "</a></div>" +
            "</td>" +
            // description column
            "<td class='col-md-5 col-sm-5 col-xs-5'>" +
                element["description"] +
            "</td>" +
            // town column
            "<td class='col-md-2 col-sm-2 col-xs-2'>" +
                (element["town"] == null ? emptyLabel : element["town"]) +
            "</td>" +
            // address column
            "<td class='col-md-2 col-sm-2 col-xs-2'>" +
                (element["address"] == null ? emptyLabel : element["address"]) +
            "</td>" +
            "</tr>";
    })
    return tableBody;
}

// Getting users list
function getUsersFromController(controller, tableID){
    $.ajax({
        url: controller,
        dataType: 'json',
        data: {
            username : $(".admin-findUser-form input[name='username']").val(),
            email : $(".admin-findUser-form input[name='email']").val(),
        },
        success: function(data) {
            updateTable(createTableWithUsers(data), tableID);
        },
        error: function(request, status, error) {
            alert(error)
        },
        complete: function() {
        }
    });
}

function createTableWithUsers(data){
    var tableBody = "";
    data.forEach(function(element, index, array){
        tableBody = tableBody +
            "<tr>"+
            // username column
            "<td class='col-md-4 col-sm-4 col-xs-4'>" +
            "<a href='/user/show/" + element["id"] + "'>" +
            element["username"] +
            "</a>" +
                "<div class='pull-right'>" +
                "<a href='/place/edit/"+ element["id"] + "'>" +
                "<span class='glyphicon glyphicon-edit'></span> " +
                editLabel + "</a></div>" +
            "</td>" +
            // email column
            "<td class='col-md-4 col-sm-4 col-xs-4'>" +
                element["email"] +
            "</td>" +
            // roles column
            "<td class='col-md-4 col-sm-4 col-xs-4'>" +
                element["role"] +
            "</td>" +
            "</tr>";
    })
    return tableBody;
}

// Updating table with new content
function updateTable(data, tableID){
    var tableBody = $("#" + tableID + " tbody");
    tableBody.html(data);
    $.bootstrapSortable(true);
}