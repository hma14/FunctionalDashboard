

$(function () {
    $("#SearchRequestTxID").bind("click", function () {
        $('#spinner').fadeIn();
    });

    $("#SearchUniqueParticipantID").bind("click", function () {
        $('#spinner').fadeIn();
    });

    $("#SearchCSN").bind("click", function () {
        $('#spinner').fadeIn();
    });
});

$(".refresh").bind("click", function () {
    $('#spinner').fadeIn();
});



// jQuery function: for switching between ACK/CLEAR/UNCLEAR 

$(function () {
    $('a#clear61').click(UpdateLogLevel(61, 'FileDetails', '/DetailedFileUpass/FileDetailsUpdateErrorListStatus'));
    $('a#clear62').click(UpdateLogLevel(62, 'FileDetails', '/DetailedFileUpass/FileDetailsUpdateErrorListStatus'));
    $('a#clear63').click(UpdateLogLevel(63, 'FileDetails', '/DetailedFileUpass/FileDetailsUpdateErrorListStatus'));
    $('a#clear64').click(UpdateLogLevel(64, 'FileDetails', '/DetailedFileUpass/FileDetailsUpdateErrorListStatus'));
    $('a#clear65').click(UpdateLogLevel(65, 'FileDetails', '/DetailedFileUpass/FileDetailsUpdateErrorListStatus'));
    $('a#clear66').click(UpdateLogLevel(66, 'FileDetails', '/DetailedFileUpass/FileDetailsUpdateErrorListStatus'));
    $('a#clear67').click(UpdateLogLevel(67, 'FileDetails', '/DetailedFileUpass/FileDetailsUpdateErrorListStatus'));
    $('a#clear68').click(UpdateLogLevel(68, 'FileDetails', '/DetailedFileUpass/FileDetailsUpdateErrorListStatus'));
    $('a#clear69').click(UpdateLogLevel(69, 'FileDetails', '/DetailedFileUpass/FileDetailsUpdateErrorListStatus'));
    $('a#clear70').click(UpdateLogLevel(70, 'FileDetails', '/DetailedFileUpass/FileDetailsUpdateErrorListStatus'));

    return false;
});


$(function () {


    $('a#notes61').popBox({
        program: $('a#notes61').data('id'), institution: $('a#notes61').data('id2'), institutionId: $('a#notes61').data('id3'),
        cate: $('a#notes61').data('id4'), cateId: $('a#notes61').data('id5'),
        evt: $('a#notes61').data('id6'), evtId: $('a#notes61').data('id7'),
        errorId: $('a#notes61').data('id8'), errorDesc: $('a#notes61').data('id9'),
        errorStatus: $('a#notes61').data('id10'),
        processDatetimeTicks: $('a#notes61').data('id11'),

    });

    $('a#notes62').popBox({
        program: $('a#notes62').data('id'), institution: $('a#notes62').data('id2'), institutionId: $('a#notes62').data('id3'),
        cate: $('a#notes62').data('id4'), cateId: $('a#notes62').data('id5'),
        evt: $('a#notes62').data('id6'), evtId: $('a#notes62').data('id7'),
        errorId: $('a#notes62').data('id8'), errorDesc: $('a#notes62').data('id9'),
        errorStatus: $('a#notes62').data('id10'),
        processDatetimeTicks: $('a#notes62').data('id11'),
    });
    $('a#notes63').popBox({
        program: $('a#notes63').data('id'), institution: $('a#notes63').data('id2'), institutionId: $('a#notes63').data('id3'),
        cate: $('a#notes63').data('id4'), cateId: $('a#notes63').data('id5'),
        evt: $('a#notes63').data('id6'), evtId: $('a#notes63').data('id7'),
        errorId: $('a#notes63').data('id8'), errorDesc: $('a#notes63').data('id9'),
        errorStatus: $('a#notes63').data('id10'),
        processDatetimeTicks: $('a#notes63').data('id11'),

    });
    $('a#notes64').popBox({
        program: $('a#notes64').data('id'), institution: $('a#notes64').data('id2'), institutionId: $('a#notes64').data('id3'),
        cate: $('a#notes64').data('id4'), cateId: $('a#notes64').data('id5'),
        evt: $('a#notes64').data('id6'), evtId: $('a#notes64').data('id7'),
        errorId: $('a#notes64').data('id8'), errorDesc: $('a#notes64').data('id9'),
        errorStatus: $('a#notes64').data('id10'),
        processDatetimeTicks: $('a#notes64').data('id11'),

    });
    $('a#notes65').popBox({
        program: $('a#notes65').data('id'), institution: $('a#notes65').data('id2'), institutionId: $('a#notes65').data('id3'),
        cate: $('a#notes65').data('id4'), cateId: $('a#notes65').data('id5'),
        evt: $('a#notes65').data('id6'), evtId: $('a#notes65').data('id7'),
        errorId: $('a#notes65').data('id8'), errorDesc: $('a#notes65').data('id9'),
        errorStatus: $('a#notes65').data('id10'),
        processDatetimeTicks: $('a#notes65').data('id11'),

    });
    $('a#notes66').popBox({
        program: $('a#notes66').data('id'), institution: $('a#notes66').data('id2'), institutionId: $('a#notes66').data('id3'),
        cate: $('a#notes66').data('id4'), cateId: $('a#notes66').data('id5'),
        evt: $('a#notes66').data('id6'), evtId: $('a#notes66').data('id7'),
        errorId: $('a#notes66').data('id8'), errorDesc: $('a#notes66').data('id9'),
        errorStatus: $('a#notes66').data('id10'),
        processDatetimeTicks: $('a#notes66').data('id11'),

    });
    $('a#notes67').popBox({
        program: $('a#notes67').data('id'), institution: $('a#notes67').data('id2'), institutionId: $('a#notes67').data('id3'),
        cate: $('a#notes67').data('id4'), cateId: $('a#notes67').data('id5'),
        evt: $('a#notes67').data('id6'), evtId: $('a#notes67').data('id7'),
        errorId: $('a#notes67').data('id8'), errorDesc: $('a#notes67').data('id9'),
        errorStatus: $('a#notes67').data('id10'),
        processDatetimeTicks: $('a#notes67').data('id11'),
    });
    $('a#notes68').popBox({
        program: $('a#notes68').data('id'), institution: $('a#notes68').data('id2'), institutionId: $('a#notes68').data('id3'),
        cate: $('a#notes68').data('id4'), cateId: $('a#notes68').data('id5'),
        evt: $('a#notes68').data('id6'), evtId: $('a#notes68').data('id7'),
        errorId: $('a#notes68').data('id8'), errorDesc: $('a#notes68').data('id9'),
        errorStatus: $('a#notes68').data('id10'),
        processDatetimeTicks: $('a#notes68').data('id11'),

    });
    $('a#notes69').popBox({
        program: $('a#notes69').data('id'), institution: $('a#notes69').data('id2'), institutionId: $('a#notes69').data('id3'),
        cate: $('a#notes69').data('id4'), cateId: $('a#notes69').data('id5'),
        evt: $('a#notes69').data('id6'), evtId: $('a#notes69').data('id7'),
        errorId: $('a#notes69').data('id8'), errorDesc: $('a#notes69').data('id9'),
        errorStatus: $('a#notes69').data('id10'),
        processDatetimeTicks: $('a#notes69').data('id11'),

    });
    $('a#notes70').popBox({
        program: $('a#notes70').data('id'), institution: $('a#notes70').data('id2'), institutionId: $('a#notes70').data('id3'),
        cate: $('a#notes70').data('id4'), cateId: $('a#notes70').data('id5'),
        evt: $('a#notes70').data('id6'), evtId: $('a#notes70').data('id7'),
        errorId: $('a#notes70').data('id8'), errorDesc: $('a#notes70').data('id9'),
        errorStatus: $('a#notes70').data('id10'),
        processDatetimeTicks: $('a#notes70').data('id11'),

    });

});

$(function () {

    // KnowledgeBase Popup
    $('a#event61').KnowledgeBasePopup({
        program: $('a#event61').data('id'), cate: $('a#event61').data('id2'), cateId: $('a#event61').data('id3'),
        evt: $('a#event61').data('id4'), evtId: $('a#event61').data('id5'),
        updatedBy: $('a#event61').data('id6'), updatedDatetime: $('a#event61').data('id7'),
    });
    $('a#event62').KnowledgeBasePopup({
        program: $('a#event62').data('id'), cate: $('a#event62').data('id2'), cateId: $('a#event62').data('id3'),
        evt: $('a#event62').data('id4'), evtId: $('a#event62').data('id5'),
        updatedBy: $('a#event62').data('id6'), updatedDatetime: $('a#event62').data('id7'),
    });
    $('a#event63').KnowledgeBasePopup({
        program: $('a#event63').data('id'), cate: $('a#event63').data('id2'), cateId: $('a#event63').data('id3'),
        evt: $('a#event63').data('id4'), evtId: $('a#event63').data('id5'),
        updatedBy: $('a#event63').data('id6'), updatedDatetime: $('a#event63').data('id7'),
    });
    $('a#event64').KnowledgeBasePopup({
        program: $('a#event64').data('id'), cate: $('a#event64').data('id2'), cateId: $('a#event64').data('id3'),
        evt: $('a#event64').data('id4'), evtId: $('a#event64').data('id5'),
        updatedBy: $('a#event64').data('id6'), updatedDatetime: $('a#event64').data('id7'),
    });
    $('a#event65').KnowledgeBasePopup({
        program: $('a#event65').data('id'), cate: $('a#event65').data('id2'), cateId: $('a#event65').data('id3'),
        evt: $('a#event65').data('id4'), evtId: $('a#event65').data('id5'),
        updatedBy: $('a#event65').data('id6'), updatedDatetime: $('a#event65').data('id7'),
    });

    $('a#event66').KnowledgeBasePopup({
        program: $('a#event66').data('id'), cate: $('a#event66').data('id2'), cateId: $('a#event66').data('id3'),
        evt: $('a#event66').data('id4'), evtId: $('a#event66').data('id5'),
        updatedBy: $('a#event66').data('id6'), updatedDatetime: $('a#event66').data('id7'),
    });
    $('a#event67').KnowledgeBasePopup({
        program: $('a#event67').data('id'), cate: $('a#event67').data('id2'), cateId: $('a#event67').data('id3'),
        evt: $('a#event67').data('id4'), evtId: $('a#event67').data('id5'),
        updatedBy: $('a#event67').data('id6'), updatedDatetime: $('a#event67').data('id7'),
    });
    $('a#event68').KnowledgeBasePopup({
        program: $('a#event68').data('id'), cate: $('a#event68').data('id2'), cateId: $('a#event68').data('id3'),
        evt: $('a#event68').data('id4'), evtId: $('a#event68').data('id5'),
        updatedBy: $('a#event68').data('id6'), updatedDatetime: $('a#event68').data('id7'),
    });
    $('a#event69').KnowledgeBasePopup({
        program: $('a#event69').data('id'), cate: $('a#event69').data('id2'), cateId: $('a#event69').data('id3'),
        evt: $('a#event69').data('id4'), evtId: $('a#event69').data('id5'),
        updatedBy: $('a#event69').data('id6'), updatedDatetime: $('a#event69').data('id7'),
    });
    $('a#event70').KnowledgeBasePopup({
        program: $('a#event70').data('id'), cate: $('a#event70').data('id2'), cateId: $('a#event70').data('id3'),
        evt: $('a#event70').data('id4'), evtId: $('a#event70').data('id5'),
        updatedBy: $('a#event70').data('id6'), updatedDatetime: $('a#event70').data('id7'),
    });

});
