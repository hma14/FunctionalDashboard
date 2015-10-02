

$(function () {
    $(".sltalert").bind("click", function () {
        $('#spinner12').fadeIn();
    });
    return false;
});


// jQuery function: for clearing SLT Alerts

$(function () {
    
    $('a#clearSLT11').click(ClearSLT(11, 'updateArea1', '/Home/ClearSLTAlertEntry'));
    $('a#clearSLT12').click(ClearSLT(12, 'updateArea1', '/Home/ClearSLTAlertEntry'));
    $('a#clearSLT13').click(ClearSLT(13, 'updateArea1', '/Home/ClearSLTAlertEntry'));
    $('a#clearSLT14').click(ClearSLT(14, 'updateArea1', '/Home/ClearSLTAlertEntry'));
    $('a#clearSLT15').click(ClearSLT(15, 'updateArea1', '/Home/ClearSLTAlertEntry'));
   

    return false;
});


$(function () {
    // Notes Popup
    $('a#notes71').popBoxSLT({
        ID: $('a#notes71').data('id'),
        program: $('a#notes71').data('id1'),
        institution: $('a#notes71').data('id2'),
        institutionId: $('a#notes71').data('id3'),
        cate: $('a#notes71').data('id4'),
        cateId: $('a#notes71').data('id5'),
        evt: $('a#notes71').data('id6'),
        evtId: $('a#notes71').data('id7'),
        RuleDescription: $('a#notes71').data('id8'),
        SLTWarningDatetime: $('a#notes71').data('id9'),
        SLTBreachDatetime: $('a#notes71').data('id10'),
    });
    $('a#notes72').popBoxSLT({
        ID: $('a#notes72').data('id'),
        program: $('a#notes72').data('id1'),
        institution: $('a#notes72').data('id2'),
        institutionId: $('a#notes72').data('id3'),
        cate: $('a#notes72').data('id4'),
        cateId: $('a#notes72').data('id5'),
        evt: $('a#notes72').data('id6'),
        evtId: $('a#notes72').data('id7'),
        RuleDescription: $('a#notes72').data('id8'),
        SLTWarningDatetime: $('a#notes72').data('id9'),
        SLTBreachDatetime: $('a#notes72').data('id10'),
    });
    $('a#notes73').popBoxSLT({
        ID: $('a#notes73').data('id'),
        program: $('a#notes73').data('id1'),
        institution: $('a#notes73').data('id2'),
        institutionId: $('a#notes73').data('id3'),
        cate: $('a#notes73').data('id4'),
        cateId: $('a#notes73').data('id5'),
        evt: $('a#notes73').data('id6'),
        evtId: $('a#notes73').data('id7'),
        RuleDescription: $('a#notes73').data('id8'),
        SLTWarningDatetime: $('a#notes73').data('id9'),
        SLTBreachDatetime: $('a#notes73').data('id10'),
    });
    $('a#notes74').popBoxSLT({
        ID: $('a#notes74').data('id'),
        program: $('a#notes74').data('id1'),
        institution: $('a#notes74').data('id2'),
        institutionId: $('a#notes74').data('id3'),
        cate: $('a#notes74').data('id4'),
        cateId: $('a#notes74').data('id5'),
        evt: $('a#notes74').data('id6'),
        evtId: $('a#notes74').data('id7'),
        RuleDescription: $('a#notes74').data('id8'),
        SLTWarningDatetime: $('a#notes74').data('id9'),
        SLTBreachDatetime: $('a#notes74').data('id10'),
    });
    $('a#notes75').popBoxSLT({
        ID: $('a#notes75').data('id'),
        program: $('a#notes75').data('id1'),
        institution: $('a#notes75').data('id2'),
        institutionId: $('a#notes75').data('id3'),
        cate: $('a#notes75').data('id4'),
        cateId: $('a#notes75').data('id5'),
        evt: $('a#notes75').data('id6'),
        evtId: $('a#notes75').data('id7'),
        RuleDescription: $('a#notes75').data('id8'),
        SLTWarningDatetime: $('a#notes75').data('id9'),
        SLTBreachDatetime: $('a#notes75').data('id10'),
    });

});


