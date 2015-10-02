
$(function () {
    $('#StartDatepickerWSPpass').datepicker();
    $('#EndDatepickerWSPpass').datepicker();
});

$(function () {

    $("#submitPpassWS").bind("click", function () {
        $('#spinnerWSPpass').fadeIn();
        $('input#EndDatepickerWSPpass').UpdateDateStatus({ start: $('input#StartDatepickerWSPpass').val(), end: $('input#EndDatepickerWSPpass').val() });
    });

    $("#SearchUniqueParticipantID").bind("click", function () {
        $('#spinnerWSPpass').fadeIn();
    });

    $("#SearchCSN").bind("click", function () {
        $('#spinnerWSPpass').fadeIn();
    });

    $("#SearchElapsedTime").bind("click", function () {
        $('#spinnerWSPpass').fadeIn();
    });

    $("#ExportWSPDF").bind("click", function () {
        $('.spinner').fadeIn();
    });
});

// jQuery function: Hide/Expand events via [+]/[-] for a category 
$(function () {

    $('a#cate1').click(DropDownEvents(1, '/ProgramPpass/GetEvents'));
    $('a#cate2').click(DropDownEvents(2, '/ProgramPpass/GetEvents'));
    $('a#cate3').click(DropDownEvents(3, '/ProgramPpass/GetEvents'));
    $('a#cate4').click(DropDownEvents(4, '/ProgramPpass/GetEvents'));
    $('a#cate5').click(DropDownEvents(5, '/ProgramPpass/GetEvents'));
    $('a#cate6').click(DropDownEvents(6, '/ProgramPpass/GetEvents'));
    $('a#cate7').click(DropDownEvents(7, '/ProgramPpass/GetEvents'));
    $('a#cate8').click(DropDownEvents(8, '/ProgramPpass/GetEvents'));
    $('a#cate9').click(DropDownEvents(9, '/ProgramPpass/GetEvents'));
    $('a#cate10').click(DropDownEvents(10, '/ProgramPpass/GetEvents'));

    return false;

});

$(function () {

    $('a#31').click(ErrorDescription(0, 31));
    $('a#32').click(ErrorDescription(1, 32));
    $('a#33').click(ErrorDescription(2, 33));
    $('a#34').click(ErrorDescription(3, 34));
    $('a#35').click(ErrorDescription(4, 35));
    $('a#36').click(ErrorDescription(5, 36));
    $('a#37').click(ErrorDescription(6, 37));
    $('a#38').click(ErrorDescription(7, 38));
    $('a#39').click(ErrorDescription(8, 39));
    $('a#40').click(ErrorDescription(9, 40));

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

    $('a#event6').KnowledgeBasePopup({
        program: $('a#event6').data('id'), cate: $('a#event6').data('id2'), cateId: $('a#event6').data('id3'),
        evt: $('a#event6').data('id4'), evtId: $('a#event6').data('id5'),
        updatedBy: $('a#event6').data('id6'), updatedDatetime: $('a#event6').data('id7'),
    });
    $('a#event7').KnowledgeBasePopup({
        program: $('a#event7').data('id'), cate: $('a#event7').data('id2'), cateId: $('a#event7').data('id3'),
        evt: $('a#event7').data('id4'), evtId: $('a#event7').data('id5'),
        updatedBy: $('a#event7').data('id6'), updatedDatetime: $('a#event7').data('id7'),
    });
    $('a#event8').KnowledgeBasePopup({
        program: $('a#event8').data('id'), cate: $('a#event8').data('id2'), cateId: $('a#event8').data('id3'),
        evt: $('a#event8').data('id4'), evtId: $('a#event8').data('id5'),
        updatedBy: $('a#event8').data('id6'), updatedDatetime: $('a#event8').data('id7'),
    });
    $('a#event9').KnowledgeBasePopup({
        program: $('a#event9').data('id'), cate: $('a#event9').data('id2'), cateId: $('a#event9').data('id3'),
        evt: $('a#event9').data('id4'), evtId: $('a#event9').data('id5'),
        updatedBy: $('a#event9').data('id6'), updatedDatetime: $('a#event9').data('id7'),
    });
    $('a#event10').KnowledgeBasePopup({
        program: $('a#event10').data('id'), cate: $('a#event10').data('id2'), cateId: $('a#event10').data('id3'),
        evt: $('a#event10').data('id4'), evtId: $('a#event10').data('id5'),
        updatedBy: $('a#event10').data('id6'), updatedDatetime: $('a#event10').data('id7'),
    });

});