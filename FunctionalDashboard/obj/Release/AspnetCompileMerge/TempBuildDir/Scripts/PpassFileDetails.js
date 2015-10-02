
$(function () {
    $("#SearchRequestTxID").bind("click", function () {
        $('#spinner6').fadeIn();
    });

    $("#SearchUniqueParticipantID").bind("click", function () {
        $('#spinner6').fadeIn();
    });

    $("#SearchCSN").bind("click", function () {
        $('#spinner6').fadeIn();
    });
});

$(".refresh").bind("click", function () {
    $('#spinner6').fadeIn();
});



// jQuery function: for switching between ACK/CLEAR/UNCLEAR 

$(function () {
    $('a#clear41').click(UpdateLogLevel(41, 'FileDetails', '/DetailedFilePpass/FileDetailsUpdateErrorListStatus'));
    $('a#clear42').click(UpdateLogLevel(42, 'FileDetails', '/DetailedFilePpass/FileDetailsUpdateErrorListStatus'));
    $('a#clear43').click(UpdateLogLevel(43, 'FileDetails', '/DetailedFilePpass/FileDetailsUpdateErrorListStatus'));
    $('a#clear44').click(UpdateLogLevel(44, 'FileDetails', '/DetailedFilePpass/FileDetailsUpdateErrorListStatus'));
    $('a#clear45').click(UpdateLogLevel(45, 'FileDetails', '/DetailedFilePpass/FileDetailsUpdateErrorListStatus'));
    $('a#clear46').click(UpdateLogLevel(46, 'FileDetails', '/DetailedFilePpass/FileDetailsUpdateErrorListStatus'));
    $('a#clear47').click(UpdateLogLevel(47, 'FileDetails', '/DetailedFilePpass/FileDetailsUpdateErrorListStatus'));
    $('a#clear48').click(UpdateLogLevel(48, 'FileDetails', '/DetailedFilePpass/FileDetailsUpdateErrorListStatus'));
    $('a#clear49').click(UpdateLogLevel(49, 'FileDetails', '/DetailedFilePpass/FileDetailsUpdateErrorListStatus'));
    $('a#clear50').click(UpdateLogLevel(50, 'FileDetails', '/DetailedFilePpass/FileDetailsUpdateErrorListStatus'));

    return false;
});


$(function () {


    $('a#notes41').popBox({
        program: $('a#notes41').data('id'), institution: $('a#notes41').data('id2'), institutionId: $('a#notes41').data('id3'),
        cate: $('a#notes41').data('id4'), cateId: $('a#notes41').data('id5'),
        evt: $('a#notes41').data('id6'), evtId: $('a#notes41').data('id7'),
        errorId: $('a#notes41').data('id8'), errorDesc: $('a#notes41').data('id9'),
        errorStatus: $('a#notes41').data('id10'),
        processDatetimeTicks: $('a#notes41').data('id11'),

    });

    $('a#notes42').popBox({
        program: $('a#notes42').data('id'), institution: $('a#notes42').data('id2'), institutionId: $('a#notes42').data('id3'),
        cate: $('a#notes42').data('id4'), cateId: $('a#notes42').data('id5'),
        evt: $('a#notes42').data('id6'), evtId: $('a#notes42').data('id7'),
        errorId: $('a#notes42').data('id8'), errorDesc: $('a#notes42').data('id9'),
        errorStatus: $('a#notes42').data('id10'),
        processDatetimeTicks: $('a#notes42').data('id11'),
    });
    $('a#notes43').popBox({
        program: $('a#notes43').data('id'), institution: $('a#notes43').data('id2'), institutionId: $('a#notes43').data('id3'),
        cate: $('a#notes43').data('id4'), cateId: $('a#notes43').data('id5'),
        evt: $('a#notes43').data('id6'), evtId: $('a#notes43').data('id7'),
        errorId: $('a#notes43').data('id8'), errorDesc: $('a#notes43').data('id9'),
        errorStatus: $('a#notes43').data('id10'),
        processDatetimeTicks: $('a#notes43').data('id11'),

    });
    $('a#notes44').popBox({
        program: $('a#notes44').data('id'), institution: $('a#notes44').data('id2'), institutionId: $('a#notes44').data('id3'),
        cate: $('a#notes44').data('id4'), cateId: $('a#notes44').data('id5'),
        evt: $('a#notes44').data('id6'), evtId: $('a#notes44').data('id7'),
        errorId: $('a#notes44').data('id8'), errorDesc: $('a#notes44').data('id9'),
        errorStatus: $('a#notes44').data('id10'),
        processDatetimeTicks: $('a#notes44').data('id11'),

    });
    $('a#notes45').popBox({
        program: $('a#notes45').data('id'), institution: $('a#notes45').data('id2'), institutionId: $('a#notes45').data('id3'),
        cate: $('a#notes45').data('id4'), cateId: $('a#notes45').data('id5'),
        evt: $('a#notes45').data('id6'), evtId: $('a#notes45').data('id7'),
        errorId: $('a#notes45').data('id8'), errorDesc: $('a#notes45').data('id9'),
        errorStatus: $('a#notes45').data('id10'),
        processDatetimeTicks: $('a#notes45').data('id11'),

    });
    $('a#notes46').popBox({
        program: $('a#notes46').data('id'), institution: $('a#notes46').data('id2'), institutionId: $('a#notes46').data('id3'),
        cate: $('a#notes46').data('id4'), cateId: $('a#notes46').data('id5'),
        evt: $('a#notes46').data('id6'), evtId: $('a#notes46').data('id7'),
        errorId: $('a#notes46').data('id8'), errorDesc: $('a#notes46').data('id9'),
        errorStatus: $('a#notes46').data('id10'),
        processDatetimeTicks: $('a#notes46').data('id11'),

    });
    $('a#notes47').popBox({
        program: $('a#notes47').data('id'), institution: $('a#notes47').data('id2'), institutionId: $('a#notes47').data('id3'),
        cate: $('a#notes47').data('id4'), cateId: $('a#notes47').data('id5'),
        evt: $('a#notes47').data('id6'), evtId: $('a#notes47').data('id7'),
        errorId: $('a#notes47').data('id8'), errorDesc: $('a#notes47').data('id9'),
        errorStatus: $('a#notes47').data('id10'),
        processDatetimeTicks: $('a#notes47').data('id11'),
    });
    $('a#notes48').popBox({
        program: $('a#notes48').data('id'), institution: $('a#notes48').data('id2'), institutionId: $('a#notes48').data('id3'),
        cate: $('a#notes48').data('id4'), cateId: $('a#notes48').data('id5'),
        evt: $('a#notes48').data('id6'), evtId: $('a#notes48').data('id7'),
        errorId: $('a#notes48').data('id8'), errorDesc: $('a#notes48').data('id9'),
        errorStatus: $('a#notes48').data('id10'),
        processDatetimeTicks: $('a#notes48').data('id11'),

    });
    $('a#notes49').popBox({
        program: $('a#notes49').data('id'), institution: $('a#notes49').data('id2'), institutionId: $('a#notes49').data('id3'),
        cate: $('a#notes49').data('id4'), cateId: $('a#notes49').data('id5'),
        evt: $('a#notes49').data('id6'), evtId: $('a#notes49').data('id7'),
        errorId: $('a#notes49').data('id8'), errorDesc: $('a#notes49').data('id9'),
        errorStatus: $('a#notes49').data('id10'),
        processDatetimeTicks: $('a#notes49').data('id11'),

    });
    $('a#notes50').popBox({
        program: $('a#notes50').data('id'), institution: $('a#notes50').data('id2'), institutionId: $('a#notes50').data('id3'),
        cate: $('a#notes50').data('id4'), cateId: $('a#notes50').data('id5'),
        evt: $('a#notes50').data('id6'), evtId: $('a#notes50').data('id7'),
        errorId: $('a#notes50').data('id8'), errorDesc: $('a#notes50').data('id9'),
        errorStatus: $('a#notes50').data('id10'),
        processDatetimeTicks: $('a#notes50').data('id11'),

    });

});


$(function () {

    // KnowledgeBase Popup
    $('a#event41').KnowledgeBasePopup({
        program: $('a#event41').data('id'), cate: $('a#event41').data('id2'), cateId: $('a#event41').data('id3'),
        evt: $('a#event41').data('id4'), evtId: $('a#event41').data('id5'),
        updatedBy: $('a#event41').data('id6'), updatedDatetime: $('a#event41').data('id7'),
    });
    $('a#event42').KnowledgeBasePopup({
        program: $('a#event42').data('id'), cate: $('a#event42').data('id2'), cateId: $('a#event42').data('id3'),
        evt: $('a#event42').data('id4'), evtId: $('a#event42').data('id5'),
        updatedBy: $('a#event42').data('id6'), updatedDatetime: $('a#event42').data('id7'),
    });
    $('a#event43').KnowledgeBasePopup({
        program: $('a#event43').data('id'), cate: $('a#event43').data('id2'), cateId: $('a#event43').data('id3'),
        evt: $('a#event43').data('id4'), evtId: $('a#event43').data('id5'),
        updatedBy: $('a#event43').data('id6'), updatedDatetime: $('a#event43').data('id7'),
    });
    $('a#event44').KnowledgeBasePopup({
        program: $('a#event44').data('id'), cate: $('a#event44').data('id2'), cateId: $('a#event44').data('id3'),
        evt: $('a#event44').data('id4'), evtId: $('a#event44').data('id5'),
        updatedBy: $('a#event44').data('id6'), updatedDatetime: $('a#event44').data('id7'),
    });
    $('a#event45').KnowledgeBasePopup({
        program: $('a#event45').data('id'), cate: $('a#event45').data('id2'), cateId: $('a#event45').data('id3'),
        evt: $('a#event45').data('id4'), evtId: $('a#event45').data('id5'),
        updatedBy: $('a#event45').data('id6'), updatedDatetime: $('a#event45').data('id7'),
    });

    $('a#event46').KnowledgeBasePopup({
        program: $('a#event46').data('id'), cate: $('a#event46').data('id2'), cateId: $('a#event46').data('id3'),
        evt: $('a#event46').data('id4'), evtId: $('a#event46').data('id5'),
        updatedBy: $('a#event46').data('id6'), updatedDatetime: $('a#event46').data('id7'),
    });
    $('a#event47').KnowledgeBasePopup({
        program: $('a#event47').data('id'), cate: $('a#event47').data('id2'), cateId: $('a#event47').data('id3'),
        evt: $('a#event47').data('id4'), evtId: $('a#event47').data('id5'),
        updatedBy: $('a#event47').data('id6'), updatedDatetime: $('a#event47').data('id7'),
    });
    $('a#event48').KnowledgeBasePopup({
        program: $('a#event48').data('id'), cate: $('a#event48').data('id2'), cateId: $('a#event48').data('id3'),
        evt: $('a#event48').data('id4'), evtId: $('a#event48').data('id5'),
        updatedBy: $('a#event48').data('id6'), updatedDatetime: $('a#event48').data('id7'),
    });
    $('a#event49').KnowledgeBasePopup({
        program: $('a#event49').data('id'), cate: $('a#event49').data('id2'), cateId: $('a#event49').data('id3'),
        evt: $('a#event49').data('id4'), evtId: $('a#event49').data('id5'),
        updatedBy: $('a#event49').data('id6'), updatedDatetime: $('a#event49').data('id7'),
    });
    $('a#event50').KnowledgeBasePopup({
        program: $('a#event50').data('id'), cate: $('a#event50').data('id2'), cateId: $('a#event50').data('id3'),
        evt: $('a#event50').data('id4'), evtId: $('a#event50').data('id5'),
        updatedBy: $('a#event50').data('id6'), updatedDatetime: $('a#event50').data('id7'),
    });

});