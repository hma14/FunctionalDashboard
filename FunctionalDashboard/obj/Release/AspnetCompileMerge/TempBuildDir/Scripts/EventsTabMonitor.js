
$(function () {
    $('#StartDatepicker').datepicker();
    $('#EndDatepicker').datepicker();
});

$(function () {
    $("#submit").bind("click", function () {
        $('#spinner').fadeIn();
        $('input#StartDatepicker').UpdateDateStatus({ start: $('input#StartDatepicker').val(), end: $('input#EndDatepicker').val() });
    });
});



$(".refresh").bind("click", function () {
    $('#spinner').fadeIn();
});


// jQuery function: Hide/Expand events via [+]/[-] for a category 
$(function () {

    $('a#cate1').click(DropDownEvents(1, '/Home/GetTabMonitorEvents'));
    $('a#cate2').click(DropDownEvents(2, '/Home/GetTabMonitorEvents'));
    $('a#cate3').click(DropDownEvents(3, '/Home/GetTabMonitorEvents'));
    $('a#cate4').click(DropDownEvents(4, '/Home/GetTabMonitorEvents'));
    $('a#cate5').click(DropDownEvents(5, '/Home/GetTabMonitorEvents'));

    return false;

});

// jQuery function: for switching between ACK/CLEAR/UNCLEAR 

$(function () {
    $('a#clear1').click(UpdateLogLevel(1, 'updateArea', '/Home/UpdateErrorListStatus'));
    $('a#clear2').click(UpdateLogLevel(2, 'updateArea', '/Home/UpdateErrorListStatus'));
    $('a#clear3').click(UpdateLogLevel(3, 'updateArea', '/Home/UpdateErrorListStatus'));
    $('a#clear4').click(UpdateLogLevel(4, 'updateArea', '/Home/UpdateErrorListStatus'));
    $('a#clear5').click(UpdateLogLevel(5, 'updateArea', '/Home/UpdateErrorListStatus'));
    $('a#clear51').click(UpdateLogLevel(51, 'updateArea', '/Home/UpdateErrorListStatus'));
    $('a#clear52').click(UpdateLogLevel(52, 'updateArea', '/Home/UpdateErrorListStatus'));
    $('a#clear53').click(UpdateLogLevel(53, 'updateArea', '/Home/UpdateErrorListStatus'));
    $('a#clear54').click(UpdateLogLevel(54, 'updateArea', '/Home/UpdateErrorListStatus'));
    $('a#clear55').click(UpdateLogLevel(55, 'updateArea', '/Home/UpdateErrorListStatus'));

    return false;
});


$(function () {
    // Notes Popup
    $('a#notes1').popBox({
        program: $('a#notes1').data('id'), institution: $('a#notes1').data('id2'), institutionId: $('a#notes1').data('id3'),
        cate: $('a#notes1').data('id4'), cateId: $('a#notes1').data('id5'),
        evt: $('a#notes1').data('id6'), evtId: $('a#notes1').data('id7'),
        errorId: $('a#notes1').data('id8'), errorDesc: $('a#notes1').data('id9'),
        errorStatus: $('a#notes1').data('id10'),
        processDatetimeTicks: $('a#notes1').data('id11'),

    });
    $('a#notes2').popBox({
        program: $('a#notes2').data('id'), institution: $('a#notes2').data('id2'), institutionId: $('a#notes2').data('id3'),
        cate: $('a#notes2').data('id4'), cateId: $('a#notes2').data('id5'),
        evt: $('a#notes2').data('id6'), evtId: $('a#notes2').data('id7'),
        errorId: $('a#notes2').data('id8'), errorDesc: $('a#notes2').data('id9'),
        errorStatus: $('a#notes2').data('id10'),
        processDatetimeTicks: $('a#notes2').data('id11'),
    });
    $('a#notes3').popBox({
        program: $('a#notes3').data('id'), institution: $('a#notes3').data('id2'), institutionId: $('a#notes3').data('id3'),
        cate: $('a#notes3').data('id4'), cateId: $('a#notes3').data('id5'),
        evt: $('a#notes3').data('id6'), evtId: $('a#notes3').data('id7'),
        errorId: $('a#notes3').data('id8'), errorDesc: $('a#notes3').data('id9'),
        errorStatus: $('a#notes3').data('id10'),
        processDatetimeTicks: $('a#notes3').data('id11'),

    });
    $('a#notes4').popBox({
        program: $('a#notes4').data('id'), institution: $('a#notes4').data('id2'), institutionId: $('a#notes4').data('id3'),
        cate: $('a#notes4').data('id4'), cateId: $('a#notes4').data('id5'),
        evt: $('a#notes4').data('id6'), evtId: $('a#notes4').data('id7'),
        errorId: $('a#notes4').data('id8'), errorDesc: $('a#notes4').data('id9'),
        errorStatus: $('a#notes4').data('id10'),
        processDatetimeTicks: $('a#notes4').data('id11'),

    });
    $('a#notes5').popBox({
        program: $('a#notes5').data('id'), institution: $('a#notes5').data('id2'), institutionId: $('a#notes5').data('id3'),
        cate: $('a#notes5').data('id4'), cateId: $('a#notes5').data('id5'),
        evt: $('a#notes5').data('id6'), evtId: $('a#notes5').data('id7'),
        errorId: $('a#notes5').data('id8'), errorDesc: $('a#notes5').data('id9'),
        errorStatus: $('a#notes5').data('id10'),
        processDatetimeTicks: $('a#notes5').data('id11'),

    });

    $('a#notes51').popBox({
        program: $('a#notes51').data('id'), institution: $('a#notes51').data('id2'), institutionId: $('a#notes51').data('id3'),
        cate: $('a#notes51').data('id4'), cateId: $('a#notes51').data('id5'),
        evt: $('a#notes51').data('id6'), evtId: $('a#notes51').data('id7'),
        errorId: $('a#notes51').data('id8'), errorDesc: $('a#notes51').data('id9'),
        errorStatus: $('a#notes51').data('id10'),
        processDatetimeTicks: $('a#notes51').data('id11'),

    });
    $('a#notes52').popBox({
        program: $('a#notes52').data('id'), institution: $('a#notes52').data('id2'), institutionId: $('a#notes52').data('id3'),
        cate: $('a#notes52').data('id4'), cateId: $('a#notes52').data('id5'),
        evt: $('a#notes52').data('id6'), evtId: $('a#notes52').data('id7'),
        errorId: $('a#notes52').data('id8'), errorDesc: $('a#notes52').data('id9'),
        errorStatus: $('a#notes52').data('id10'),
        processDatetimeTicks: $('a#notes52').data('id11'),
    });
    $('a#notes53').popBox({
        program: $('a#notes53').data('id'), institution: $('a#notes53').data('id2'), institutionId: $('a#notes53').data('id3'),
        cate: $('a#notes53').data('id4'), cateId: $('a#notes53').data('id5'),
        evt: $('a#notes53').data('id6'), evtId: $('a#notes53').data('id7'),
        errorId: $('a#notes53').data('id8'), errorDesc: $('a#notes53').data('id9'),
        errorStatus: $('a#notes53').data('id10'),
        processDatetimeTicks: $('a#notes53').data('id11'),

    });
    $('a#notes54').popBox({
        program: $('a#notes54').data('id'), institution: $('a#notes54').data('id2'), institutionId: $('a#notes54').data('id3'),
        cate: $('a#notes54').data('id4'), cateId: $('a#notes54').data('id5'),
        evt: $('a#notes54').data('id6'), evtId: $('a#notes54').data('id7'),
        errorId: $('a#notes54').data('id8'), errorDesc: $('a#notes54').data('id9'),
        errorStatus: $('a#notes54').data('id10'),
        processDatetimeTicks: $('a#notes54').data('id11'),

    });
    $('a#notes55').popBox({
        program: $('a#notes55').data('id'), institution: $('a#notes55').data('id2'), institutionId: $('a#notes55').data('id3'),
        cate: $('a#notes55').data('id4'), cateId: $('a#notes55').data('id5'),
        evt: $('a#notes55').data('id6'), evtId: $('a#notes55').data('id7'),
        errorId: $('a#notes55').data('id8'), errorDesc: $('a#notes55').data('id9'),
        errorStatus: $('a#notes55').data('id10'),
        processDatetimeTicks: $('a#notes55').data('id11'),

    });

    return false;
});


$(function () {

    // KnowledgeBase Popup
    $('a#event1').KnowledgeBasePopup({
        program: $('a#event1').data('id'), cate: $('a#event1').data('id2'), cateId: $('a#event1').data('id3'),
        evt: $('a#event1').data('id4'), evtId: $('a#event1').data('id5'),
        updatedBy: $('a#event1').data('id6'), updatedDatetime: $('a#event1').data('id7'),
    });
    $('a#event2').KnowledgeBasePopup({
        program: $('a#event2').data('id'), cate: $('a#event2').data('id2'), cateId: $('a#event2').data('id3'),
        evt: $('a#event2').data('id4'), evtId: $('a#event2').data('id5'),
        updatedBy: $('a#event2').data('id6'), updatedDatetime: $('a#event2').data('id7'),
    });
    $('a#event3').KnowledgeBasePopup({
        program: $('a#event3').data('id'), cate: $('a#event3').data('id2'), cateId: $('a#event3').data('id3'),
        evt: $('a#event3').data('id4'), evtId: $('a#event3').data('id5'),
        updatedBy: $('a#event3').data('id6'), updatedDatetime: $('a#event3').data('id7'),
    });
    $('a#event4').KnowledgeBasePopup({
        program: $('a#event4').data('id'), cate: $('a#event4').data('id2'), cateId: $('a#event4').data('id3'),
        evt: $('a#event4').data('id4'), evtId: $('a#event4').data('id5'),
        updatedBy: $('a#event4').data('id6'), updatedDatetime: $('a#event4').data('id7'),
    });
    $('a#event5').KnowledgeBasePopup({
        program: $('a#event5').data('id'), cate: $('a#event5').data('id2'), cateId: $('a#event5').data('id3'),
        evt: $('a#event5').data('id4'), evtId: $('a#event5').data('id5'),
        updatedBy: $('a#event5').data('id6'), updatedDatetime: $('a#event5').data('id7'),
    });

    $('a#event11').KnowledgeBasePopup({
        program: $('a#event11').data('id'), cate: $('a#event11').data('id2'), cateId: $('a#event11').data('id3'),
        evt: $('a#event11').data('id4'), evtId: $('a#event11').data('id5'),
        updatedBy: $('a#event11').data('id6'), updatedDatetime: $('a#event11').data('id7'),
    });
    $('a#event12').KnowledgeBasePopup({
        program: $('a#event12').data('id'), cate: $('a#event12').data('id2'), cateId: $('a#event12').data('id3'),
        evt: $('a#event12').data('id4'), evtId: $('a#event12').data('id5'),
        updatedBy: $('a#event12').data('id6'), updatedDatetime: $('a#event12').data('id7'),
    });
    $('a#event13').KnowledgeBasePopup({
        program: $('a#event13').data('id'), cate: $('a#event13').data('id2'), cateId: $('a#event13').data('id3'),
        evt: $('a#event13').data('id4'), evtId: $('a#event13').data('id5'),
        updatedBy: $('a#event13').data('id6'), updatedDatetime: $('a#event13').data('id7'),
    });
    $('a#event14').KnowledgeBasePopup({
        program: $('a#event14').data('id'), cate: $('a#event14').data('id2'), cateId: $('a#event14').data('id3'),
        evt: $('a#event14').data('id4'), evtId: $('a#event14').data('id5'),
        updatedBy: $('a#event14').data('id6'), updatedDatetime: $('a#event14').data('id7'),
    });
    $('a#event15').KnowledgeBasePopup({
        program: $('a#event15').data('id'), cate: $('a#event15').data('id2'), cateId: $('a#event15').data('id3'),
        evt: $('a#event15').data('id4'), evtId: $('a#event15').data('id5'),
        updatedBy: $('a#event15').data('id6'), updatedDatetime: $('a#event15').data('id7'),
    });


    $('a#event51').KnowledgeBasePopup({
        program: $('a#event51').data('id'), cate: $('a#event51').data('id2'), cateId: $('a#event51').data('id3'),
        evt: $('a#event51').data('id4'), evtId: $('a#event51').data('id5'),
        updatedBy: $('a#event51').data('id6'), updatedDatetime: $('a#event51').data('id7'),
    });
    $('a#event52').KnowledgeBasePopup({
        program: $('a#event52').data('id'), cate: $('a#event52').data('id2'), cateId: $('a#event52').data('id3'),
        evt: $('a#event52').data('id4'), evtId: $('a#event52').data('id5'),
        updatedBy: $('a#event52').data('id6'), updatedDatetime: $('a#event52').data('id7'),
    });
    $('a#event53').KnowledgeBasePopup({
        program: $('a#event53').data('id'), cate: $('a#event53').data('id2'), cateId: $('a#event53').data('id3'),
        evt: $('a#event53').data('id4'), evtId: $('a#event53').data('id5'),
        updatedBy: $('a#event53').data('id6'), updatedDatetime: $('a#event53').data('id7'),
    });
    $('a#event54').KnowledgeBasePopup({
        program: $('a#event54').data('id'), cate: $('a#event54').data('id2'), cateId: $('a#event54').data('id3'),
        evt: $('a#event54').data('id4'), evtId: $('a#event54').data('id5'),
        updatedBy: $('a#event54').data('id6'), updatedDatetime: $('a#event54').data('id7'),
    });
    $('a#event55').KnowledgeBasePopup({
        program: $('a#event55').data('id'), cate: $('a#event55').data('id2'), cateId: $('a#event55').data('id3'),
        evt: $('a#event55').data('id4'), evtId: $('a#event55').data('id5'),
        updatedBy: $('a#event55').data('id6'), updatedDatetime: $('a#event55').data('id7'),
    });

    return false;
});

