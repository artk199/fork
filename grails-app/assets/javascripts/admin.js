// Setting default labels in view
var editLabel, emptyLabel, rejectLabel, acceptLabel,
    noPendingLabel, closeReportLabel, removeLabel, noFlaggedCommentsLabel;

function setEditLabel(label){editLabel = label;}
function setEmptyLabel(label){emptyLabel = label;}
function setRejectLabel(label){rejectLabel = label;}
function setAcceptLabel(label){acceptLabel = label;}
function setNoPendingLabel(label){noPendingLabel = label;}
function setCloseReportLabel(label){closeReportLabel = label;}
function setRemoveLabel(label){removeLabel = label;}
function setNoFlaggedCommentsLabel(label){noFlaggedCommentsLabel = label;}

// Getting places list
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

var updateImagesCount = 0;

// Updates photo list
function updateImages(controller, containerID, imageID){
    $.ajax({
        url: controller,
        dataType: 'json',
        data: {
            id : imageID
        },
        success: function(data) {
            var html = createImagesContainer(data, containerID);
            updateImagesContainer(html, containerID)
        },
        error: function(request, status, error) {
            alert(error)
        },
        complete: function() {
        }
    });
}

// Create div container
function createImagesContainer(data, containerID){
    var rejectController = "/admin/rejectImage";
    var acceptController = "/admin/acceptImage";
    var containerHTML = "";
    var i = 0;
    data.forEach(function(element, index, array){
        containerHTML = containerHTML +
            "<div class='admin-image-tile pull-left'>" +
            (element["title"] == null ? "" :
                "<div class='pos'><span class='glyphicon glyphicon-picture'></span>" +
                "<span>" + element["title"] + "</span></div>"
            ) +
            "<div class='image-container'><span class='helper'></span>" +
            "<img src='/image/" + element["id"] + "'/></div>" +
            "<div class='pos'><span class='glyphicon glyphicon-calendar'></span>" +
            "<span>" + element["dateCreated"] + "</span></div>" +
            "<div class='pos'><span class='glyphicon glyphicon-user'></span>" +
            "<span><a href='/user/show/'>" + element["user_name"] + "</a></span></div>" +
            (element["place_id"] == null ? "" :
                "<div class='pos'><span class='glyphicon glyphicon-map-marker'></span>" +
                "<span><a href='/place/show/'>" + element["place_name"] + "</a></span></div>"
            ) +
            "<div class='buttons'><a class='btn btn-default'" +
            "onclick=\"updateImages('" + rejectController + "','" + containerID + "','" + element["id"] + "')\">" +
            "<span class='glyphicon glyphicon-remove-sign'></span>" +
            "<span>" + rejectLabel + "</span></a><a class='btn btn-default'" +
            "onclick=\"updateImages('" + acceptController + "','" + containerID + "','" + element["id"] + "')\">" +
            "<span class='glyphicon glyphicon-ok-sign'></span>" +
            "<span>" + acceptLabel + "</span></a></div></div>";
            i = i + 1;
    })

    updateImagesCount = i;

    // Display info about no pending requests
    if(i == 0){
        containerHTML = "<p>"+ noPendingLabel + "</p>";
    }
    return containerHTML;
}

// Update div with images
function updateImagesContainer(data, containerID){
    var container = $("#" + containerID);
    container.html(data);

    // Update count label on tab
    var $countLabel = $("#admin-photos-label");
    if(updateImagesCount == 0){
        $countLabel.remove();
    }
    else{
        $countLabel.html(updateImagesCount);
    }
}

// Update comments section
function updateComments(controller, containerID, scoreID){
    $.ajax({
        url: controller,
        dataType: 'json',
        data: {
            id : scoreID
        },
        success: function(data) {
            createTableWithComments(data, containerID);
        },
        error: function(request, status, error) {
            alert(error)
        },
        complete: function() {
        }
    });
}

function createTableWithComments(data, containerID){
    var i = 0;
    var containerHTML = "";
    data.forEach(function(element, index, array) {
        containerHTML = containerHTML + "<tr>" +
        "<td class='col-md-2 col-sm-2 col-xs-2'><a href='/user/show/"+element["owner_id"]+"'>"+element["owner_name"]+"</a></td>" +
        "<td class='col-md-2 col-sm-2 col-xs-2'><a href='/score/edit/"+element["id"]+"'>"+element["title"]+"</a></td>" +
        "<td class='col-md-4 col-sm-4 col-xs-4'>"+element["review"]+"</a></td>"+
        "<td class='col-md-2 col-sm-2 col-xs-2'>"+element["reports_size"]+"</a></td>"+
        "<td class='col-md-2 col-sm-2 col-xs-2'>"+
            "<a class='btn btn-default btn-block' onclick=\"updateComments('/admin/closeReports', '"+containerID+"', '"+element["id"]+"')\">" +
            "<span class='glyphicon glyphicon-remove-sign'></span><span>"+closeReportLabel+"</span></a>"+
            "<a href='/score/edit/"+element["id"]+"' class='btn btn-default btn-block'>" +
            "<span class='glyphicon glyphicon-edit'></span>" + editLabel + "</a>"+
            "<a class='btn btn-default btn-block' onclick=\"updateComments('/admin/removeScore', '"+containerID+"', '"+element["id"]+"')\">" +
            "<span class='glyphicon glyphicon-remove-sign'></span><span>"+removeLabel+"</span></a>"+
            "</td>"+
        "</tr>"
        i = i + 1;
    });

    var $countLabel = $("#admin-comments-label");
    // Display info about no pending requests
    if(i == 0){
        var table = $("#" + containerID);
        var parent = table.parent();
        table.remove();
        var $newChild = $("<p>"+ noFlaggedCommentsLabel + "</p>");
        parent.append($newChild);
        $countLabel.remove();
    }
    else{
        var tableBody = $("#" + containerID + " tbody");
        tableBody.html(containerHTML);
        //$.bootstrapSortable(true);
        $countLabel.html(i);
    }

    return containerHTML;
}