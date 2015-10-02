

function DropDownEvents(n, fname) {
    var $events = $('div#events' + n);
    $events.hide();

    $('a#cate' + n).unbind('click').bind('click', function () {
        var $ID = $(this).data('id');

        $.ajax({
            type: "GET",
            url: 'http://' + window.location.host + fname,
            data: { ID:$ID },
            contentType: "application/html; charset=utf-8",
            dataType: "html",
            async: true,
            //jsonpCallback: 'jsonCallback',
            success: function (result) {
                $events.html(result);
            },
            error: function (e) {
                
                alert(e.responseText);
            }
        });

        $events.animate({ opacity: 'toggle', height: 'toggle' }, 1000);
        var $link = $(this);
        if ($link.text() == '[-]') {
            $link.text('[+]');
        }
        else {
            $link.text('[-]');
        }
        return false;
    });
}

function DropDownFiles(n, fname) {
    var $files = $('div#files' + n);    
    $files.hide();   
    $('a#file' + n).unbind('click').bind('click', function () {
       
        var $dateStartTicks = $(this).data('id');
        var $uri = $(this).data('id2');
        var $ID = $(this).data('id3');

        $.ajax({
            type: "GET",
            url: 'http://' + window.location.host + fname,
            data: { dateStartTicks: $dateStartTicks, uri: $uri, ID:$ID},
            contentType: "application/html; charset=utf-8",
            dataType: "html",
            async: true,
            success: function (result) {
                $files.html(result);
            },
            error: function (e) {
                alert(e.responseText);
            }
        });


        $files.animate({ opacity: 'toggle', height: 'toggle' }, 1000);
        var $link = $(this);
        if ($link.text() == '[-]') {
            $link.text('[+]');
        }
        else {
            $link.text('[-]');
        }
        return false;
    });
}

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



// Drop down links for errors
function ErrorDescription(m, n) {
    var $link_text = "Description and StackTrace";
    var $errors = $('p:eq(' + m + ')');
    $errors.hide();
    $('a#' + n).click(function () {
        $('p:eq(' + m + ')').animate({ opacity: 'toggle', height: 'toggle' }, 'slow');
        var $link = $(this);
        if ($link.text() == $link_text)
            $link.text('hide');
        else
            $link.text($link_text);
        return false;
    });
}


// ACK/CLEAR/UNCLEAR Errors link 

function UpdateLogLevel(n, divid, fname) {

    var $tables = $('div#' + divid);
    $('a#clear' + n).click(function () {
        var $status = 0;
        var $link = $(this);
        if ($link.text() == '[ACK]') {
            $status = 2;
        }
        else if ($link.text() == '[CLEAR]') {
            $status = 0;
        }
        else if ($link.text() == '[UNCLEAR]') {
            $status = 1;
        }

        var $program = $(this).data('id');
        var $institutionID = $(this).data('id2');
        var $cate = $(this).data('id3');
        var $evt = $(this).data('id4');
        var $processDatetimeTicks = $(this).data('id5');
        var $ID = $(this).data('id6');

        $.ajax({
            type: "GET",
            url: 'http://' + window.location.host + fname,
            data: { programID: $program, institutionID: $institutionID, cate: $cate, evt: $evt, processDatetimeTicks: $processDatetimeTicks, status: $status, ID: $ID },
            contentType: "application/html; charset=utf-8",
            dataType: "html",
            async: true,
            cache: false,
            success: function (result) {
                $tables.html(result);
            },
            error: function (error) {
                alert(error.responseText);
            }
    })
    })
}

(function ($) {

    $.fn.UpdateDateStatus = function (options) {

        var defaults = {
            start: null,
            end: null,
            forSLTAlert: null,

        };
        var options = $.extend(defaults, options); 
        var $status = $('div#Status');
        
        //alert(options.forSLTAlert);
        $.ajax({
            type: "GET",
            url: 'http://' + window.location.host + "/home/UpdateDateStatus?start=" + options.start + "&end=" + options.end + "&updatedForSLTAlert=" + options.forSLTAlert,
            contentType: "application/html; charset=utf-8",
            dataType: "html",
            async: true,
            cache: false,
            success: function (result) {
                $status.html(result);
            }
        });
        return false;
    };
})(jQuery);


(function ($) {

    $.fn.UpdatePartialViews = function (options) {

        var defaults = {
            start: null,
            end: null,
            updateArea: null,
            callBack:null,

        };
        var options = $.extend(defaults, options);
        var $section = $('div#' + options.updateArea);

        $.ajax({
            type: "GET",
            url: 'http://' + window.location.host + "/home/" + options.callBack + "?startDate=" + options.start + "&endDate=" + options.end + "&updateArea=" + options.updateArea + "&callBack=" + options.callBack,
            contentType: "application/html; charset=utf-8",
            dataType: "html",
            async: true,
            cache: false,
            success: function (result) {
                $section.html(result);
            },
            error: function (error) {
                alert(error.responseText);
            }
        });
        return false;
    };
})(jQuery);

