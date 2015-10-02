
(function ($) {

    $.fn.KnowledgeBasePopup = function (options) {

        var defaults = {
            height: 80,
            width: 800,
            newlineString: "<br/>",
            cate: null,
            cateId: null,
            evt: null,
            evtId: null,
            updatedBy: null,
            updatedDatetime: null,

        };
        var options = $.extend(defaults, options);

        return this.each(function () {

            obj = $(this);

            obj.after('<div class="popBox-holder"></div> \
                            <div class="popBox-container"> \
                            <h2 style="float:left">Knowledge Base</h2> \
                            <table class="table_short-wrap2"> \
                                <tr><td class="bold">Category (<span class="event_id_bold">id</span>)</td><td>' + options.cate + '(<span class="event_id_bold">' + options.cateId + '</span>)</td></tr> \
                                <tr><td class="bold">Event (<span class="event_id_bold">id</span>)</td><td>' + options.evt + '(<span class="event_id_bold">' + options.evtId + '</span>)</td></tr> \
                                <tr><td class="bold">Possible Severity</td><td> \
                                    <select id="ddlSeverity"> \
                                       <option value="1">1 – High</option> \
                                       <option value="2">2 – Significant</option> \
                                       <option value="3" selected="selected">3 – Regular</option> \
                                    </select> \
                                </td></tr> \
                            </table> \
                            <label  class="labelTextarea" for="eventDesc">Event Description</label> \
                            <textarea   id="eventDesc" name="eventDesc" class="labelTextarea popBox-input" rows="10" /> <br /> \
                                                                                                                    \
                            <label class="labelTextarea" for="potentialErrors">Potential Errors</label> \                                                                                                          \
                            <textarea   id="potentialErrors" name="potentialErrors" class="labelTextarea popBox-input" rows="10" />  <br />\
                                                                                                          \
                            <label class="labelTextarea" for="businessImpact">Business Impact</label> \
                            <textarea   id="businessImpact" name="businessImpact" class="labelTextarea popBox-input" rows="10" />  <br />\
                                                                        \
                            <label class="labelTextarea" for="resolution">Resolution</label> \
                            <textarea   id="resolutions" name="resolution" class="labelTextarea popBox-input" rows="10" />  <br />\
                                                                        \
                            <div class="done-button"> \
                                <input type="button" id="btSave" value="Save" class="button blue small"/> \
                                <input type="button" id="btClose" value="Close" class="button blue small"/></div> \
                            <br /> \
                            <table class="table_short-wrap2"> \
                                <tr><td class="bold">Updated by </td><td class="updatedBy"></td><td class="updatedDatetime"></td></tr> \
                            </table> \
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


                //var $dbRetrieveResult = $('div#dbRetrieveResult');
                
                $.ajax({
                    type: "GET",
                    url: 'http://' + window.location.host +  '/home/RetrieveCPGFD_KB',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: { evtId: options.evtId, cateId: options.cateId },
                    cache: false,
                    async: true,
                    success: function (msg) {
                        if (Object.keys(msg).length > 0) {                           
                            popBoxContainer.children("#eventDesc").val(msg[0].Description);
                            popBoxContainer.children("#potentialErrors").val(msg[0].PotentialErrors);
                            popBoxContainer.children("#businessImpact").val(msg[0].BusinessImpact);
                            popBoxContainer.children("#resolutions").val(msg[0].Resolutions);
                            popBoxContainer.children("#updatedBy").val(msg[0].UpdatedBy);
                            popBoxContainer.children("#updatedDatetime").val(msg[0].UpdatedDatetime);
                            $("#ddlSeverity").val(msg[0].Sev);
                            $(".updatedBy").text(msg[0].UpdatedBy);

                            var milli = msg[0].UpdatedDatetime.replace(/\/Date\((-?\d+)\)\//, '$1'); // retrieve 1341031788683 (milliseconds) from "/Date(1341031788683)/"
                            var d = new Date(parseInt(milli));                            
                            $(".updatedDatetime").text(d);
                            
                        }
                    },
                    error: function (error) {
                        alert("Error: " + error.responseText);
                    }
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
                var $isSaved = false;

                btnSaveContainer.children('input#btClose').click(function () {
                    popBoxContainer.hide();
                    popBoxContainer.prev().hide();
                    change = false;

                });

                // The .one() method is identical to  .on(), except that the handler is unbound after its first invocation.
                // 
                btnSaveContainer.children('input#btSave').one('click', function () {

                    if (change) {
                        //popBoxContainer.children('.popBox-input').val(popBoxContainer.children('.popBox-input').val().replace(RegExp(options.newlineString, "g"), "\n"));
                        //popBoxContainer.children('.popBox-input').val(popBoxContainer.children('.popBox-input').val().replace(/\</g, "&lt;"));
                        //popBoxContainer.children('.popBox-input').val(popBoxContainer.children('.popBox-input').val().replace(/\>/g, "&gt;"));                        

                        $.ajax({
                            type: "POST",
                            url: 'http://' + window.location.host +  '/home/SaveCPGFD_KB',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: JSON.stringify({
                                evtId: options.evtId,
                                cateId: options.cateId,
                                status: 1,
                                description: popBoxContainer.children("#eventDesc").val(),
                                potentialErrors: popBoxContainer.children("#potentialErrors").val(),
                                businessImpact: popBoxContainer.children("#businessImpact").val(),
                                sev: $("#ddlSeverity").val().valueOf(),
                                resolutions: popBoxContainer.children("#resolutions").val(),
                                isSaved: $isSaved
                            }),
                            cache: false,
                            async: true,

                            success: function (result) {
                                $isSaved = true;
                            },
                            error: function (error) {
                                alert("Error: " + error.statusText);
                            },
                        });
                        popBoxContainer.hide();
                        popBoxContainer.prev().hide();
                    }
                });
            });
        });
    };

})(jQuery);
