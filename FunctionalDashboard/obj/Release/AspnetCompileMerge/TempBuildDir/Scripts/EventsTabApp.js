$(function () {
    $('#StartDatepicker4').datepicker();
    $('#EndDatepicker4').datepicker();
});

$(function () {
    $("#submit4").bind("click", function () {
        $('#spinner4').fadeIn();
        $('input#StartDatepicker4').UpdateDateStatus({ start: $('input#StartDatepicker4').val(), end: $('input#EndDatepicker4').val() });
        $('input#submit4').UpdatePartialViews({ start: $('input#StartDatepicker4').val(), end: $('input#EndDatepicker4').val(), sortOrder: ' ', page: 1, updateArea: 'updateArea42', callBack: 'AppSyncUtilityOnDateRangeChanges' });
    });

})

function ClearSLT(n, divid, fname) {
    $('a#clearSLT' + n).click(function () {
        var $tables = $('div#' + divid);
        var $ID = $(this).data('id');
        var $status = $(this).data('id2');
        var $user = $(this).data('id3');

        $.ajax({
            type: "GET",
            url: 'http://' + window.location.host + fname,
            //url: 'http://' + window.location.host  + fname,
            data: { id: $ID, status: $status, user: $user },
            contentType: "application/html; charset=utf-8",
            dataType: "html",
            async: true,
            success: function (result) {
                $tables.html(result);
            },
            error: function (e) {
                alert(e.responseText);
            }
        });
        return false;
    });
}



$(".refresh").bind("click", function () {
    $('#spinner4').fadeIn();
});


$(function () {
    var $events = $('div#EventSentryStatus');
    $events.hide();

    $('a#ShowStatus').unbind('click').bind('click', function () {
        $('#spinner4').fadeIn();
        $.ajax({
            type: "GET",
            url: "/Home/MonitorEventSentry",
            contentType: "application/html; charset=utf-8",
            dataType: "html",
            async: true,
            success: function (result) {
                $events.html(result);
                $('#spinner4').fadeOut();
            }
        });

        $events.animate({ opacity: 'toggle', height: 'toggle' }, 1000);
        var $link = $(this);
        if ($link.text() == 'Hide EventSentry Status') {
            $link.text('Show EventSentry Status');
        }
        else {
            $link.text('Hide EventSentry Status');
        }
        
    });
    return false;
});
