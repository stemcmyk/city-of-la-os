let tradingOpen = false;
let mdtOpen = false;
let mdtCustomUrl = false;

function CloseAll() {
    $(".vehicle_recall").css("display", "none");
    $(".comserv_notice").css("display", "none");
    $(".wnews_publish").css("display", "none");
}

$(function () {
    window.addEventListener('message', function (event) {
        switch (event.data.display) {
            case "vehicle_recall":
                $(".vehicle_recall").css("display", event.data.value ? "block" : "none");
                break;
            case "comserv_notice":
                $(".comserv_notice").css("display", event.data.value ? "block" : "none");
                break;
            case "wnews_publish":
                $(".wnews_publish").css("display", event.data.value ? "block" : "none");
            default:
                break;
        }

        if (event.data.openMDT) {
            mdtOpen = true;

            if (event.data.customUrl !== undefined) {
                $("#mdt").attr("src", event.data.customUrl);
                mdtCustomUrl = true;
            } else if (mdtCustomUrl) {
                $("#mdt").attr("src", "https://mdt.noire.cloud");
                mdtCustomUrl = false;
            }

            if (event.data.plateLookup !== undefined) {
                $("#mdt").attr("src", "https://mdt.noire.cloud/searchplate?plate=" + event.data.plateLookup);
            }

            $(".mdt").css("display", event.data.value ? "flex" : "none");
        }

        if (event.data.resetMDT) {
            $("#mdt").attr("src", "https://mdt.noire.cloud/home?" + event.data.value);
        }

        if (event.data.closeMDT) {
            mdtOpen = false;
            // $("#mdt").attr("src", "https://mdt.noire.cloud");
            $(".mdt").css("display", "none");
        }

        if (event.data.setComservReason) {
            $("#comserv_reason").text(event.data.reason);
            $("#comserv_reason").css("font-weight", "Bold");
        }

        if (event.data.updateRecallTable) {
            $("#vehicle_table tr:gt(0)").remove();
            $("#vehicle_table").append(event.data.vehicles);
        }

        if (event.data.openTrading) {
            tradingOpen = true;

            $("#trading").attr("src", "https://trade.noire.cloud");
            $(".trading").css("display", event.data.value ? "flex" : "none");
        }

        if (event.data.closeTrading) {
            tradingOpen = false;
            $(".trading").css("display", "none");
        }

        if (event.data.openWiki) {
            wikiOpen = true;

            $("#wiki").attr("src", "https://wiki.noire.cloud");
            $(".wiki").css("display", event.data.value ? "flex" : "none");
        }

        if (event.data.closeWiki) {
            wikiOpen = false;
            $(".wiki").css("display", "none");
        }

        if (event.data.casinoStats) {
            $(".casino").css("display", "flex");
        }

        if (event.data.dojStats) {
            $(".doj").css("display", "flex");
        }

        if (event.data.closeStats) {
            $(".stats").css("display", "none");
        }
    })

    $("#wnews_submit").click(function () {
        const data = [];
        for (var i = 1; i <= 6; i++) {
            data[i - 1] = $("#page" + i).val();
        }
        CloseAll();
        $.post("https://" + GetParentResourceName() + "/submitNews", JSON.stringify({ data: data }));
    });

    window.addEventListener("keyup", (event) => {
        if ((event.code == "Escape" || event.code == "Backspace") && !mdtOpen) {
            CloseAll();
            $.post("https://" + GetParentResourceName() + "/closeNUI", JSON.stringify({}));
        }
    }, false);
});