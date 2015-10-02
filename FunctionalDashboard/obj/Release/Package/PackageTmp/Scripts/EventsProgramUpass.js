
$(function () {
    $('#StartDatepickerUpassWS').datepicker();
    $('#EndDatepickerUpassWS').datepicker();
});

$(function () {

    $("#submitUpassWS").bind("click", function () {
        $('#spinnerWSUpass').fadeIn();
        $('input#EndDatepickerUpassWS').UpdateDateStatus({ start: $('input#StartDatepickerUpassWS').val(), end: $('input#EndDatepickerUpassWS').val() });
    });

    $("#SearchUniqueParticipantID").bind("click", function () {
        $('#spinnerWSUpass').fadeIn();
    });

    $("#SearchCSN").bind("click", function () {
        $('#spinnerWSUpass').fadeIn();
    });

    $("#SearchElapsedTime").bind("click", function () {
        $('#spinnerWSUpass').fadeIn();
    });

    $("#ExportWSPDF").bind("click", function () {
        $('#spinnerWSUpass').fadeIn();
    });

});

$(".refresh").bind("click", function () {
    $('.spinnerWSUpass').fadeIn();
});


$(function () {

    $('a#21').click(ErrorDescription(0, 21));
    $('a#22').click(ErrorDescription(1, 22));
    $('a#23').click(ErrorDescription(2, 23));
    $('a#24').click(ErrorDescription(3, 24));
    $('a#25').click(ErrorDescription(4, 25));
    $('a#26').click(ErrorDescription(5, 26));
    $('a#27').click(ErrorDescription(6, 27));
    $('a#28').click(ErrorDescription(7, 28));
    $('a#29').click(ErrorDescription(8, 29));
    $('a#30').click(ErrorDescription(9, 30));

    return false;

});

// jQuery function: Hide/Expand events via [+]/[-] for a category 
$(function () {

    $('a#cate1').click(DropDownEvents(1, '/ProgramUpass/GetEvents'));
    $('a#cate2').click(DropDownEvents(2, '/ProgramUpass/GetEvents'));
    $('a#cate3').click(DropDownEvents(3, '/ProgramUpass/GetEvents'));
    $('a#cate4').click(DropDownEvents(4, '/ProgramUpass/GetEvents'));
    $('a#cate5').click(DropDownEvents(5, '/ProgramUpass/GetEvents'));
    $('a#cate6').click(DropDownEvents(6, '/ProgramUpass/GetEvents'));
    $('a#cate7').click(DropDownEvents(7, '/ProgramUpass/GetEvents'));
    $('a#cate8').click(DropDownEvents(8, '/ProgramUpass/GetEvents'));
    $('a#cate9').click(DropDownEvents(9, '/ProgramUpass/GetEvents'));
    $('a#cate10').click(DropDownEvents(10, '/ProgramUpass/GetEvents'));

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