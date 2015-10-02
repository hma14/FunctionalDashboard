$(document).ready(function () {
    $('body').scrollTop(1);

    //var iv = setInterval("logout()", 1000);

    $(this).mousemove(function () {
        timeout = 0;
    });

    $(this).keypress(function (e) {
        timeout = 0;
    });

    $(this).mousedown(function (e) {
        timeout = 0;
    });

    /** Scripts for navigation **/
    $('#nav li:has(ul)').doubleTapToGo();

    /** Scripts for dashboard **/
    // Dashboard alignment for older browser versions:
    jQuery('#flexbox > div:last-child').css("float", "right");
    jQuery('#flexbox > div:last-child').css("width", "49%");
    jQuery('.table tbody > tr:nth-child(even) td').css("background-color", "#cfdfeb");
    jQuery('.table tbody > tr:nth-child(even) th').css("background-color", "#cfdfeb");

    var checkboxes = $("input[type='checkbox']");
    if (!checkboxes.is(":checked"))
        $('#requestButton').attr('disabled', 'disabled');
    checkboxes.click(function () {
        $('#requestButton').attr("disabled", !checkboxes.is(":checked"));
    });

    if (checkboxes.length == 0) {
        $('#requestButton').css('display', 'none');
    }

    $('#info').hide();
    $('#eligInfo').hide();
    $('#benefitInfo').hide();

    $('#statusQ').click(function () {
        $('#eligInfo').hide();
        $('#benefitInfo').hide();
        $('#info').show();
    });
    $('#eligQ').click(function () {
        $('#info').hide();
        $('#benefitInfo').hide();
        $('#eligInfo').show();
    });
    $('#benefitQ').click(function () {
        $('#info').hide();
        $('#eligInfo').hide();
        $('#benefitInfo').show();
    });

    $('#closeInfo').click(function () {
        $('#info').hide();
    });
    $('#closeElig').click(function () {
        $('#eligInfo').hide();
    });
    $('#closeBenefit').click(function () {
        $('#benefitInfo').hide();
    });    

    /** Scripts for menu page **/
    if ($('#menuPage').length) {
        $('#nav').hide();
    }

    /** Scripts for link card page **/
    if (document.getElementById('CardNumber') != null && document.getElementById('Cvn') != null) {
        if ($('#CardNumber').val().length == 20 && $('#Cvn').val().length == 3) {
            $('#btnLink').removeAttr('disabled');
        } else {
            $('#btnLink').attr('disabled', 'disabled');
        }

        $('#CardNumber').keyup(function () {
            if ($('#CardNumber').val().length == 20 && $('#Cvn').val().length == 3) {
                $('#btnLink').removeAttr('disabled');
            } else {
                $('#btnLink').attr('disabled', 'disabled');
            }
        });

        $('#Cvn').keyup(function () {
            if ($('#CardNumber').val().length == 20 && $('#Cvn').val().length == 3) {
                $('#btnLink').removeAttr('disabled');
            } else {
                $('#btnLink').attr('disabled', 'disabled');
            }
        });
    }

    /** Scripts for alerts setup page **/
    var checkbox = $('#MonthlyAlert');
    if (!checkbox.is(":checked"))
        $('#Duration').attr('disabled', 'disabled');
    checkbox.click(function () {
        $('#Duration').attr("disabled", !checkbox.is(":checked"));
    });


    /** Scripts for menu **/
    function runEffect(item) {
        $(item).toggle('blind', '', 500);
    }

    $("#helpMenu").live("click", function () {
        $(this).toggleClass("collapse expended");
        runEffect('#helpItems');
        return false;
    });

    $("#divQuestions ul li div:first-child").addClass("collapse");

    // script for FAQ page
    $("#divQuestions ul").on("click", "li div:first-child", function () {
        collapseItem($(this));
    });

    $("#btnRequest").on("click", function () {
        collapseItem($("#requestbutnoteligible"));
    });

    // check status button event
    $("#btnCheckStatus").on("click", function () {
        var btn = $(this);
        var url = btn.attr("data-url");
        var data = { ccsn: btn.attr("data-ccsn") };
        $.ajax({
            url: url,
            type: "GET",
            dataType: "json",
            cache: false,
            data: data,
            beforeSend: onBegin(btn)
        })
            .done(function (data) {
                onSuccess(data);
            })
            .fail(function (xhr, status, error){
                onFailure(xhr, status, error);
            })
            .always(function (){
                onComplete(btn);
            })
    });
});


function collapseItem(div) {
    div.toggleClass("collapse expended");
    div.siblings("div").slideToggle("fast");
}
    
var timeout = 0;
function logout() {
    timeout = timeout + 1;
    //console.log("timeout = " + timeout);
    if (timeout > 300) {        
        window.location = window.location.protocol + "//" + window.location.host + ":" + window.location.port + "/fs/home/logout?logoutId=1";
		timeout = 0; 
    }
}

// include Google Analytics
(function (i, s, o, g, r, a, m) {
    i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
        (i[r].q = i[r].q || []).push(arguments)
    }, i[r].l = 1 * new Date(); a = s.createElement(o),
    m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
})(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');
ga('create', 'UA-812499-30', 'translink.ca');
ga('send', 'pageview');

// mobile menu
function checkMenu(id) {
    var menu = $("#" + id);
    if (menu.length > 0 && menu.children().length > 0) {
        menu.children().remove();
        return false;
    }
    return true;
}

// check status callback functions
function onBegin(btn) {
    btn.attr("disabled", "disabled");
}
function onSuccess(response) {
    var div = $("#divStatus");
    if (div) {
        div.fadeOut("fast");
        div.text(response.status ? "Ready to tap" : "In process");
        div.fadeIn("fast");
    }
}
function onFailure(xhr, status, error) {
    var error = $("#lblError");
    if (error) {
        error.text(xhr.status + ": " + xhr.responseText);
    }
}
function onComplete(btn) {
    btn.removeAttr("disabled");
}