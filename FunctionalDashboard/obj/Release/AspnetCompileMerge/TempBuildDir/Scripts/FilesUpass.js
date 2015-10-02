
$(function () {
    $('#StartDatepickerUpassFile').datepicker();
    $('#EndDatepickerUpassFile').datepicker();
});

$(function () {

    $("#submitUpassFile").bind("click", function () {
        $('#spinnerFileUpass').fadeIn();
        $('input#EndDatepickerUpassFile').UpdateDateStatus({ start: $('input#StartDatepickerUpassFile').val(), end: $('input#EndDatepickerUpassFile').val() });
    });

    $("#SearchFileName").bind("click", function () {
        $('#spinnerFileUpass').fadeIn();
    });


    $("#SearchUniqueParticipantID").bind("click", function () {
        $('#spinnerFileUpass').fadeIn();
    });

    $("#ExportFilePDF").bind("click", function () {
        $('#spinnerFileUpass').fadeIn();
    });


    // Refresh button
    $(".refresh").bind("click", function () {
        $('#spinnerFileUpass').fadeIn();
    });
});

// jQuery function: Hide/Expand events via [+]/[-] for a category 
$(function () {

    $('a#file1').click(DropDownFiles(1, '/ProgramUpass/GetFiles'));
    $('a#file2').click(DropDownFiles(2, '/ProgramUpass/GetFiles'));
    $('a#file3').click(DropDownFiles(3, '/ProgramUpass/GetFiles'));
    $('a#file4').click(DropDownFiles(4, '/ProgramUpass/GetFiles'));
    $('a#file5').click(DropDownFiles(5, '/ProgramUpass/GetFiles'));
    $('a#file6').click(DropDownFiles(6, '/ProgramUpass/GetFiles'));
    $('a#file7').click(DropDownFiles(7, '/ProgramUpass/GetFiles'));
    $('a#file8').click(DropDownFiles(8, '/ProgramUpass/GetFiles'));
    $('a#file9').click(DropDownFiles(9, '/ProgramUpass/GetFiles'));
    $('a#file10').click(DropDownFiles(10, '/ProgramUpass/GetFiles'));

    return false;

});

// Drop down links for erors
$(function () {

    $('a#1').click(ErrorDescription(0, 1));
    $('a#2').click(ErrorDescription(1, 2));
    $('a#3').click(ErrorDescription(2, 3));
    $('a#4').click(ErrorDescription(3, 4));
    $('a#5').click(ErrorDescription(4, 5));
    $('a#6').click(ErrorDescription(5, 6));
    $('a#7').click(ErrorDescription(6, 7));
    $('a#8').click(ErrorDescription(7, 8));
    $('a#9').click(ErrorDescription(8, 9));
    $('a#10').click(ErrorDescription(9, 20));

    return false;

});



