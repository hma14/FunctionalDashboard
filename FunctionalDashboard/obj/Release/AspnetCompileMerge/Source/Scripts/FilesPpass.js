
$(function () {
    $('#StartDatepickerFilePpass').datepicker();
    $('#EndDatepickerFilePpass').datepicker();
});

$(function () {

    $("#submitPpassFile").bind("click", function () {
        $('#spinnerFilePpass').fadeIn();
        $('input#EndDatepickerFilePpass').UpdateDateStatus({ start: $('input#StartDatepickerFilePpass').val(), end: $('input#EndDatepickerFilePpass').val() });
    });

    $("#SearchFileName").bind("click", function () {
        $('#spinnerFilePpass').fadeIn();
    });

    $("#SearchRequestTxID").bind("click", function () {
        $('#spinnerFilePpass').fadeIn();
    });

    $("#SearchUniqueParticipantID").bind("click", function () {
        $('#spinnerFilePpass').fadeIn();
    });

    $("#SearchCSN").bind("click", function () {
        $('#spinnerFilePpass').fadeIn();
    });

    $("#ExportFilePDF").bind("click", function () {
        $('#spinnerFilePpass').fadeIn();
    });

    // Refresh button
    $(".refresh").bind("click", function () {
        $('.spinner').fadeIn();
    });
});

// jQuery function: Hide/Expand events via [+]/[-] for a category 
$(function () {

    $('a#file1').click(DropDownFiles(1, '/ProgramPpass/GetFiles'));
    $('a#file2').click(DropDownFiles(2, '/ProgramPpass/GetFiles'));
    $('a#file3').click(DropDownFiles(3, '/ProgramPpass/GetFiles'));
    $('a#file4').click(DropDownFiles(4, '/ProgramPpass/GetFiles'));
    $('a#file5').click(DropDownFiles(5, '/ProgramPpass/GetFiles'));
    $('a#file6').click(DropDownFiles(6, '/ProgramPpass/GetFiles'));
    $('a#file7').click(DropDownFiles(7, '/ProgramPpass/GetFiles'));
    $('a#file8').click(DropDownFiles(8, '/ProgramPpass/GetFiles'));
    $('a#file9').click(DropDownFiles(9, '/ProgramPpass/GetFiles'));
    $('a#file10').click(DropDownFiles(10, '/ProgramPpass/GetFiles'));

    return false;

});

// Drop down links for erors

$(function () {

    $('a#11').click(ErrorDescription(0, 11));
    $('a#12').click(ErrorDescription(1, 12));
    $('a#13').click(ErrorDescription(2, 13));
    $('a#14').click(ErrorDescription(3, 14));
    $('a#15').click(ErrorDescription(4, 15));
    $('a#16').click(ErrorDescription(5, 16));
    $('a#17').click(ErrorDescription(6, 17));
    $('a#18').click(ErrorDescription(7, 18));
    $('a#19').click(ErrorDescription(8, 19));
    $('a#20').click(ErrorDescription(9, 20));

    return false;

});
