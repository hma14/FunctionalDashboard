
(function ($) {

    $.fn.popBoxSLT = function (options) {

        var defaults = {
            height: 80,
            width: 800,
            newlineString: "<br/>",
            ID: null,
            program: null,
            institution: null,
            institutionId: null,
            cate: null,
            cateId: null,
            evt: null,
            evtId: null,
            RuleDescription: null,
            SLTWarningDatetime: null,
            SLTWarningDatetime: null,

        };
        var options = $.extend(defaults, options);

        return this.each(function () {

            obj = $(this);

            var inputName = 'popBoxInput' + obj.attr("Id");
            var labelValue = $("label[for=" + obj.attr('id') + "]").text();
        
            obj.after('<div class="popBox-holder"></div> \
                            <div class="popBox-container"> \
                            <table class="table_short-wrap2" style="width:800px;font-size:2em;color:black;"><tr> \
                                <caption class="caption">SLT Tracking History</caption> \
                                <tr><td class="bold">SLT Tracking ID</td><td class="bold2">' + options.ID + '</td></tr> \
                                <tr><td class="bold">Program</td><td class="bold2">' + options.program + '</td></tr> \
                                <tr><td class="bold">Institution</td><td>' + options.institution + '</td></tr> \
                                <tr><td class="bold">Category (<span class="event_id_bold">id</span>)</td><td>' + options.cate + ' (<span class="event_id_bold">' + options.cateId + '</span>)</td></tr> \
                                <tr><td class="bold">Event (<span class="event_id_bold">id</span>)</td><td>' + options.evt + ' (<span class="event_id_bold">' + options.evtId + '</span>)</td></tr> \
                                <tr><td class="bold">Rule Description</td><td>' + options.RuleDescription + '</td></tr> \
                                <tr><td class="bold">SLT WarningDatetime</td><td>' + options.SLTWarningDatetime + '</td></tr> \
                                <tr><td class="bold">SLTBreachDatetime </td><td>' + options.SLTBreachDatetime + '</td></tr> \
                            </table> \
                            <label style="display: none;" for="' + inputName + '">' + labelValue + '</label> \
                            <textarea   id="' + inputName + '" name="' + inputName + '" class="popBox-input" rows="50" /> \
                            <div class="done-button"> \
                                <input type="button" id="btSave" value="Save" class="button blue small"/> \
                                <input type="button" id="btClose" value="Close" class="button blue small"/></div> \
                            <br /> \
                            <div style="overflow-y:auto;height:400px;" id="dbRetrieveResult"></div> \
                        </div>');
           


            obj.focus(function () {
                $(this).next(".popBox-holder").show();
                var popBoxContainer = $(this).next().next(".popBox-container");
                var btnSaveContainer = popBoxContainer.children(".done-button");
                var change = true;
                popBoxContainer.children('.popBox-input').css({ height: options.height, width: options.width });
                popBoxContainer.show();

                var winH = $(window).height();
                var winW = $(window).width();
                var objH = popBoxContainer.height();
                var objW = popBoxContainer.width();
                var left = (winW / 2) - (objW / 2);
                // var top = (winH / 2) - (objH / 2);
                var top = 0;

                popBoxContainer.css({ position: 'fixed', margin: 0, top: (top > 0 ? top : 0) + 'px', left: (left > 0 ? left : 0) + 'px' });


                var $dbRetrieveResult = $('div#dbRetrieveResult');
                $.ajax({

                    type: "GET",
                    url: 'http://' + window.location.host + "/home/RetrieveSLTTrackingHistory?cate=" + options.cateId + "&evt=" + options.evtId +
                        "&programID=" + options.program + "&institutionId=" + options.institutionId,
                    contentType: "application/html; charset=utf-8",
                    dataType: "html",
                    cache: false,
                    async: true,
                    success: function (result) {
                        if (result != null && result != '') {
                            $dbRetrieveResult.html(result);
                            $dbRetrieveResult.show();
                        }
                        else {
                            popBoxContainer.children('.popBox-input').hide();
                            btnSaveContainer.children('input#btSave').hide();
                            $dbRetrieveResult.hide();
                        }
                    },
                });

                popBoxContainer.children('.popBox-input').val($(this).val().replace(RegExp(options.newlineString, "g"), "\n"));
                popBoxContainer.children('.popBox-input').focus();

                popBoxContainer.children().keydown(function (e) {
                    if (e == null) { // ie
                        keycode = event.keyCode;
                    } else { // mozilla
                        keycode = e.which;
                    }

                    if (keycode == 27) { // close
                        $(this).parent().hide();
                        $(this).parent().prev().hide();
                        change = false;

                    }
                });

                btnSaveContainer.children('input#btClose').one('click', function () {
                    popBoxContainer.hide();
                    popBoxContainer.prev().hide();
                    change = false;

                });

                // The .one() method is identical to  .on(), except that the handler is unbound after its first invocation.
                // 
                btnSaveContainer.children('input#btSave').one('click', function () {

                    if (change) {
                        popBoxContainer.children('.popBox-input').val(popBoxContainer.children('.popBox-input').val().replace(RegExp(options.newlineString, "g"), "\n"));
                        popBoxContainer.children('.popBox-input').val(popBoxContainer.children('.popBox-input').val().replace(/\</g, "&lt;"));
                        popBoxContainer.children('.popBox-input').val(popBoxContainer.children('.popBox-input').val().replace(/\>/g, "&gt;"));
                        var $message = encodeURIComponent(popBoxContainer.children('.popBox-input').val());

                        $.ajax({
                            type: "POST",
                            url: 'http://' + window.location.host + "/home/SaveSLTTrackingHistory?trackingID=" + options.ID + "&message=" + $message,
                            contentType: "application/html; charset=utf-8",
                            dataType: "html",
                            cache: false,
                            async: true,
                            error: function (error) {
                                alert(error.statusText);
                            },
                        });
                        popBoxContainer.hide();
                        popBoxContainer.prev().hide();
                        return false;
                    }
                    
                  
                });
            });
        });
    };

})(jQuery);
