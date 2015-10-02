// For same view different TABs

$(function () {
    $('#StartDatepicker3').datepicker();
    $('#EndDatepicker3').datepicker();
});

$(function () {
    $("#submit3").bind("click", function () {
        $('#spinner3').fadeIn();
        $('input#EndDatepicker3').UpdateDateStatus({ start: $('input#StartDatepicker3').val(), end: $('input#EndDatepicker3').val() });
    });
})

$(".refresh").bind("click", function () {
    $('#spinner3').fadeIn();
});

// jQuery function: Hide/Expand events via [+]/[-] for a category 
$(function () {

    $('a#cate10').click(DropDownEvents(10, '/Home/GetTabWSEvents'));
    $('a#cate11').click(DropDownEvents(11, '/Home/GetTabWSEvents'));
    $('a#cate12').click(DropDownEvents(12, '/Home/GetTabWSEvents'));
    $('a#cate13').click(DropDownEvents(13, '/Home/GetTabWSEvents'));
    $('a#cate14').click(DropDownEvents(14, '/Home/GetTabWSEvents'));
    $('a#cate15').click(DropDownEvents(15, '/Home/GetTabWSEvents'));

    return false;

});

// jQuery function: for switching between ACK/CLEAR/UNCLEAR 

//$(function () {
//    $('a#clear1').click(UpdateLogLevel(1, 'updateArea3', '/Home/WSUpdateErrorListStatus'));
//    $('a#clear2').click(UpdateLogLevel(2, 'updateArea3', '/Home/WSUpdateErrorListStatus'));
//    $('a#clear3').click(UpdateLogLevel(3, 'updateArea3', '/Home/WSUpdateErrorListStatus'));
//    $('a#clear4').click(UpdateLogLevel(4, 'updateArea3', '/Home/WSUpdateErrorListStatus'));
//    $('a#clear5').click(UpdateLogLevel(5, 'updateArea3', '/Home/WSUpdateErrorListStatus'));
//    $('a#clear51').click(UpdateLogLevel(51, 'updateArea3', '/Home/WSUpdateErrorListStatus'));
//    $('a#clear52').click(UpdateLogLevel(52, 'updateArea3', '/Home/WSUpdateErrorListStatus'));
//    $('a#clear53').click(UpdateLogLevel(53, 'updateArea3', '/Home/WSUpdateErrorListStatus'));
//    $('a#clear54').click(UpdateLogLevel(54, 'updateArea3', '/Home/WSUpdateErrorListStatus'));
//    $('a#clear55').click(UpdateLogLevel(55, 'updateArea3', '/Home/WSUpdateErrorListStatus'));

//    return false;
//});


$(function () {

    // KnowledgeBase Popup
    $('a#event31').KnowledgeBasePopup({
        program: $('a#event31').data('id'), cate: $('a#event31').data('id2'), cateId: $('a#event31').data('id3'),
        evt: $('a#event31').data('id4'), evtId: $('a#event31').data('id5'),
        updatedBy: $('a#event31').data('id6'), updatedDatetime: $('a#event31').data('id7'),
    });
    $('a#event32').KnowledgeBasePopup({
        program: $('a#event32').data('id'), cate: $('a#event32').data('id2'), cateId: $('a#event32').data('id3'),
        evt: $('a#event32').data('id4'), evtId: $('a#event32').data('id5'),
        updatedBy: $('a#event32').data('id6'), updatedDatetime: $('a#event32').data('id7'),
    });
    $('a#event33').KnowledgeBasePopup({
        program: $('a#event33').data('id'), cate: $('a#event33').data('id2'), cateId: $('a#event33').data('id3'),
        evt: $('a#event33').data('id4'), evtId: $('a#event33').data('id5'),
        updatedBy: $('a#event33').data('id6'), updatedDatetime: $('a#event33').data('id7'),
    });
    $('a#event34').KnowledgeBasePopup({
        program: $('a#event34').data('id'), cate: $('a#event34').data('id2'), cateId: $('a#event34').data('id3'),
        evt: $('a#event34').data('id4'), evtId: $('a#event34').data('id5'),
        updatedBy: $('a#event34').data('id6'), updatedDatetime: $('a#event34').data('id7'),
    });
    $('a#event35').KnowledgeBasePopup({
        program: $('a#event35').data('id'), cate: $('a#event35').data('id2'), cateId: $('a#event35').data('id3'),
        evt: $('a#event35').data('id4'), evtId: $('a#event35').data('id5'),
        updatedBy: $('a#event35').data('id6'), updatedDatetime: $('a#event35').data('id7'),
    });
});