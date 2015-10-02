
$(function () {
    $('#StartDatepicker2').datepicker();
    $('#EndDatepicker2').datepicker();
});

$(function () {
    $("#submit2").bind("click", function () {
        $('#spinner2').fadeIn();
        $('input#EndDatepicker2').UpdateDateStatus({ start: $('input#StartDatepicker2').val(), end: $('input#EndDatepicker2').val() });
    });
});

$(".refresh").bind("click", function () {
    $('#spinner2').fadeIn();
});

$(".refresh").bind("click", function () {
    $('#spinner2').fadeIn();
});



// jQuery function: for switching between ACK/CLEAR/UNCLEAR 

$(function () {
    $('a#clear21').click(UpdateLogLevel(21, 'updateArea2', '/Home/FilesUpdateErrorListStatus'));
    $('a#clear22').click(UpdateLogLevel(22, 'updateArea2', '/Home/FilesUpdateErrorListStatus'));
    $('a#clear23').click(UpdateLogLevel(23, 'updateArea2', '/Home/FilesUpdateErrorListStatus'));
    $('a#clear24').click(UpdateLogLevel(24, 'updateArea2', '/Home/FilesUpdateErrorListStatus'));
    $('a#clear25').click(UpdateLogLevel(25, 'updateArea2', '/Home/FilesUpdateErrorListStatus'));

    return false;
});

$(function () {

    $('a#notes21').popBox({
        program: $('a#notes21').data('id'), institution: $('a#notes21').data('id2'), institutionId: $('a#notes21').data('id3'),
        cate: $('a#notes21').data('id4'), cateId: $('a#notes21').data('id5'),
        evt: $('a#notes21').data('id6'), evtId: $('a#notes21').data('id7'),
        errorId: $('a#notes21').data('id8'), errorDesc: $('a#notes21').data('id9'),
        errorStatus: $('a#notes21').data('id10'),
        processDatetimeTicks: $('a#notes21').data('id11'),

    });
    $('a#notes22').popBox({
        program: $('a#notes22').data('id'), institution: $('a#notes22').data('id2'), institutionId: $('a#notes22').data('id3'),
        cate: $('a#notes22').data('id4'), cateId: $('a#notes22').data('id5'),
        evt: $('a#notes22').data('id6'), evtId: $('a#notes22').data('id7'),
        errorId: $('a#notes22').data('id8'), errorDesc: $('a#notes22').data('id9'),
        errorStatus: $('a#notes22').data('id10'),
        processDatetimeTicks: $('a#notes22').data('id11'),
    });
    $('a#notes23').popBox({
        program: $('a#notes23').data('id'), institution: $('a#notes23').data('id2'), institutionId: $('a#notes23').data('id3'),
        cate: $('a#notes23').data('id4'), cateId: $('a#notes23').data('id5'),
        evt: $('a#notes23').data('id6'), evtId: $('a#notes23').data('id7'),
        errorId: $('a#notes23').data('id8'), errorDesc: $('a#notes23').data('id9'),
        errorStatus: $('a#notes23').data('id10'),
        processDatetimeTicks: $('a#notes23').data('id11'),

    });
    $('a#notes24').popBox({
        program: $('a#notes24').data('id'), institution: $('a#notes24').data('id2'), institutionId: $('a#notes24').data('id3'),
        cate: $('a#notes24').data('id4'), cateId: $('a#notes24').data('id5'),
        evt: $('a#notes24').data('id6'), evtId: $('a#notes24').data('id7'),
        errorId: $('a#notes24').data('id8'), errorDesc: $('a#notes24').data('id9'),
        errorStatus: $('a#notes24').data('id10'),
        processDatetimeTicks: $('a#notes24').data('id11'),

    });
    $('a#notes25').popBox({
        program: $('a#notes25').data('id'), institution: $('a#notes25').data('id2'), institutionId: $('a#notes25').data('id3'),
        cate: $('a#notes25').data('id4'), cateId: $('a#notes25').data('id5'),
        evt: $('a#notes25').data('id6'), evtId: $('a#notes25').data('id7'),
        errorId: $('a#notes25').data('id8'), errorDesc: $('a#notes25').data('id9'),
        errorStatus: $('a#notes25').data('id10'),
        processDatetimeTicks: $('a#notes25').data('id11'),

    });
});

$(function () {

    // KnowledgeBase Popup
    $('a#event21').KnowledgeBasePopup({
        program: $('a#event21').data('id'), cate: $('a#event21').data('id2'), cateId: $('a#event21').data('id3'),
        evt: $('a#event21').data('id4'), evtId: $('a#event21').data('id5'),
        updatedBy: $('a#event21').data('id6'), updatedDatetime: $('a#event21').data('id7'),
    });
    $('a#event22').KnowledgeBasePopup({
        program: $('a#event22').data('id'), cate: $('a#event22').data('id2'), cateId: $('a#event22').data('id3'),
        evt: $('a#event22').data('id4'), evtId: $('a#event22').data('id5'),
        updatedBy: $('a#event22').data('id6'), updatedDatetime: $('a#event22').data('id7'),
    });
    $('a#event23').KnowledgeBasePopup({
        program: $('a#event23').data('id'), cate: $('a#event23').data('id2'), cateId: $('a#event23').data('id3'),
        evt: $('a#event23').data('id4'), evtId: $('a#event23').data('id5'),
        updatedBy: $('a#event23').data('id6'), updatedDatetime: $('a#event23').data('id7'),
    });
    $('a#event24').KnowledgeBasePopup({
        program: $('a#event24').data('id'), cate: $('a#event24').data('id2'), cateId: $('a#event24').data('id3'),
        evt: $('a#event24').data('id4'), evtId: $('a#event24').data('id5'),
        updatedBy: $('a#event24').data('id6'), updatedDatetime: $('a#event24').data('id7'),
    });
    $('a#event25').KnowledgeBasePopup({
        program: $('a#event25').data('id'), cate: $('a#event25').data('id2'), cateId: $('a#event25').data('id3'),
        evt: $('a#event25').data('id4'), evtId: $('a#event25').data('id5'),
        updatedBy: $('a#event25').data('id6'), updatedDatetime: $('a#event25').data('id7'),
    });
});