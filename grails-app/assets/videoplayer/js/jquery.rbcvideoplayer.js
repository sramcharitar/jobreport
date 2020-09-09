/*
 * RBC Video Player - jQuery plugin to implement flowplayer-based video player with custom HTML-based controlbar for RBC.
 *
 * @author Cliff Lee
 * @version 1.2.2
 */

/**
 * Apply video player to element(s) referenced by the jQuery object this plugin is invoked on. Every element must be an anchor element with href referencing
 * video to be played, and must wrap a splash image with explicit dimensions.
 *
 * @param Object options An object containing settings to override the defaults
 * - options.transcript: URL of transcript page (optional)
 * - options.captions: URL of captions XML file (optional)
 * - options.lang: "en" or "fr" (optional, defaults to "en")
 * - options.scanInterval: Interval (in ms) at which to perform rewinds / fast forwards while rewind / fast forward control is depressed (optional, defaults to 100)
 * - options.scanFactor: Amount (as a percentage of duration) to rewind / fast forward at each interval (optional, defaults to .05)
 * - options.flowplayerParams: flowplayer params to pass directly to flowplayer() (optional)
 * - options.flowplayerConfig: flowplayer config to pass directly to flowplayer() (optional)
 */
(function($) {

    // language-specific text
    var REPLAY_EN = "Replay";
    var REPLAY_FR = "Reprendre la lecture";

    // select flowplayer key based on domain
    var FLOWPLAYER_KEYS = {
        "70.38.70.253": "a44c8f3b0113b5398fb", // staging
        "rbc.com": "a3bb401d05d5123a192",
        "sterbc.com": "86c011937ddb0d49865",
        "rbcinsurance.com": "da3d6974201aa1f7dc3",
        "sterbcinsurance.com": "673f7ee3b4353a4c723",
        "rbcassurances.com": "2676417a2068a321694",
        "sterbcassurances.com": "2dacae1b08cc3354e18",
        "rbcroyalbank.com": "ea4b034fb73b795e506",
        "sterbcroyalbank.com": "df2d2a48585cea8a8de",
        "rbcbanqueroyale.com": "1fd8a85c0558755b614",
        "sterbcbanqueroyale.com": "8c4908508275d5f2afe",
        "rbcstandards-staging.com": "12b92faa3633fe8be42",
        "rbconlinebanking.com": "563f4754fda11bad0e6",
        "sterbconlinebanking.com": "50e65b8c8044d753235",
        "royalbank.com": "0c732504ef8fbd50c0a",
        "steroyalbank.com": "8ba86cedfed4657c3cc",
        "rbconlinestandards.com": "1b712ab6160319ad34c",
        "sterbconlinestandards.com": "a8d51ffc05113b68eff",
        "rbcgma.com": "38aa4dfd5e4943fbee6",
        "sterbcgma.com": "d4be151efc961ef6066",
        "rbcgam.com": "147415f1105240385c6",
        "sterbcgam.com": "a7aa20fd4aebda597a8",
        "cartewestjetworldmastercardrbc.com": "d29644255c7244702d4",
        "stecartewestjetworldmastercardrbc.com": "8ebd87d1a21813baf77",
        "rbcadvisorservices.com": "2fb8f7688c58cb8dd72",
        "sterbcadvisorservices.com": "7f38e7f224b0d6f83f1",
        "rbccorrespondentservices.com": "7ccc00f18c79eb5516d",
        "sterbccorrespondentservices.com": "85faceca43ca585e397",
        "rbcfinancialplanning.com": "a028b136bd60dbba9f7",
        "sterbcfinancialplanning.com": "bd3c1a52b67c5fe2c06",
        "rbcgfs.com": "92246e79bb1aacd1ae1",
        "sterbcgfs.com": "847af46d1649bb9abdd",
        "rbcinvestments.com": "9b3280a6e27e13e27ac",
        "sterbcinvestments.com": "d0feba08e1950570583",
        "rbcmortgagecapital.com": "2b68bb4fd12253efc0e",
        "sterbcmortgagecapital.com": "90b6c1bab63e3476a0c",
        "rbcphnic.com": "c3fb6bfb100ea0df7b9",
        "sterbcphnic.com": "d943eecd03d6de8196b",
        "rbcplayhockey.com": "c522c676d988cff8b1c",
        "sterbcplayhockey.com": "c88290df3edb1e9a778",
        "rbcsfc.com": "148186e81a13c8a956c",
        "sterbcsfc.com": "522b595ce6bfe6815db",
        "rbcstandards.com": "3db975e889b52b46057",
        "sterbcstandards.com": "35169f33f77b5c01da1",
        "rbcvivelehockey.com": "d54376b96aa66bea6a4",
        "sterbcvivelehockey.com": "ab41cdfab80dc38bf93",
        "rbcwm-int.com": "f04e62aeab90d0f9890",
        "sterbcwm-int.com": "b82f805eb1447f39e59",
        "soldedecarterbc.com": "dc00cf7039ab2991a5f",
        "stesoldedecarterbc.com": "645e0b8de98061e6652",
        "westjetrbcworldmastercard.com": "940547ea12fe0e7e76f",
        "stewestjetrbcworldmastercard.com": "d55bfc8bebd75127b14",
        "amextravelassurance.com": "4a5660c8613f47feb42",
        "steamextravelassurance.com": "9b0fc98145011cc686e",
        "mondialprotect.com": "fc9c368070da2c9e9a4",
        "stemondialprotect.com": "dfafd54fd9209fb3ec7",
        "rbcbankusa.com": "dcdb233a19c2a28aed4",
        "sterbcbankusa.com": "27684eae0f2e572fb92",
        "rbccustomswitch.com": "44af069e066aab7fd45",
        "sterbccustomswitch.com": "6a9026849af89f48ec7",
        "rbcdirectinvesting.com": "32b2c69f6679c64dc32",
        "sterbcdirectinvesting.com": "4699c9dcbb019bd9089",
        "rbcds.com": "193d1c716c697b41d37",
        "sterbcds.com": "6ae342033e9a0b34b57",
        "rbcdvm.com": "e18dc051a81801b450e",
        "sterbcdvm.com": "c1407cc3162cbaa4210",
        "rbcgestiondepatrimoine.com": "62d98792667791497d2",
        "sterbcgestiondepatrimoine.com": "b4448cf58137d7ad23a",
        "rbcplacementsendirect.com": "b607f9217fef22c0f31",
        "sterbcplacementsendirect.com": "d56a8564df77e893769",
        "rbcrecompenses.com": "7a22fffb9728614976c",
        "sterbcrecompenses.com": "e4b879685910ded7887",
        "rbcrewards.com": "b4dacddc44325815e86",
        "sterbcrewards.com": "97e9e4bd9c71c26652e",
        "rbctravelprotection.com": "138cb753a71d2410622",
        "sterbctravelprotection.com": "235d1daa8bcb92ae3df",
        "rbcvisainfinite.com": "49eb89a8710a1a3e60a",
        "sterbcvisainfinite.com": "1ee0135de29d0c8cac8",
        "rbcwealthmanagement.com": "6b7af5280749fc6f9dd",
        "sterbcwealthmanagement.com": "df9619424974ec53c2a",
        "rbtt.com": "6b6b2000a80d5bbd182",
        "sterbtt.com": "ce8330267f94345d226",
        "rcapleasing.com": "b4da13096c296bd27da",
        "stercapleasing.com": "dd902cff70b43ae70a9",
        "transfertsurmesurerbc.com": "7f0b0c82bb1a5d40206",
        "stetransfertsurmesurerbc.com": "72e4f11c593fb8871ed",
        "visainfiniterbc.com": "ff92eba9fb5278b422e",
        "stevisainfiniterbc.com": "8f37be11f9ecdf08f6c",
        "worldprotect.com": "3bf48a3e70a67a8435f",
        "steworldprotect.com": "2118a9219c381cbe6bc",
        "amextravelinsurance.com": "3c66a07b70d338485b2",
        "steamextravelinsurance.com": "15ba251936105d478c6",
        "rbcadvicecentre.com": "30b1efe17fc93aa9be8",
        "centredexpertiserbc.com": "a2456a7d07edaddb22d",
        "cment.net": "dcf7ba2faf42986f371",
        "rbccampus.com": "f969e03f49bd338062f"
    };
    var flowplayerKey = "";
    for (var domain in FLOWPLAYER_KEYS) {
        var re = new RegExp("\\b" + domain.replace(/\./g, "\\.") + "$", "i"); // produces equivalent of: /\bmy_domain\.com$/i
        if (re.test(window.location.hostname)) {
            flowplayerKey = FLOWPLAYER_KEYS[domain];
            break;
        }
    }

    $.fn.rbcvideoplayer = function(options) {

        // default settings (except flowplayerConfig which is done further below on a per-element basis; it is not defined here since it is dependent on final values of other settings)
        var defaults = {
            transcript: null,
            captions: null,
            lang: "en",
            scanInterval: 100,
            scanFactor: .05,
            flowplayerParams: {
                src: "/uos/_assets/rbcvideoplayer/flowplayer/flowplayer.unlimited-3.2.10.swf",
                wmode: "opaque"
            }
        };

        return this.each(function() {

            var $player = $(this); // the link in which video player will be inserted

            // don't re-invoke rbcvideoplayer if already invoked
            if ($player.data("rbcvideoplayer-invoked")) {
                return;
            }
            $player.data("rbcvideoplayer-invoked", true);

            // combine default settings with html5 data attributes and plugin options, with plugin options taking precedence
            var settings = $.extend(true, {}, defaults, $player.data(), options);

            // ensure $player has an id so it can be passed to flowplayer()
            var id = $player.attr("id") || ("video-" + Math.random * 1000000);
            $player.attr("id", id);

            $player.addClass("rbcvideoplayer").css({
                width: $player.find("img").width(), // required for flowplayer
                height: $player.find("img").height() // required for flowplayer
            }).attr("tabindex", "-1"); // don't want original player element to be tabbable, since it is effectively being replaced by the video player

            // youtube vid on iDevices are problematic, so just leave $player as splash image linking directly to youtube, but draw play button on top
            var isYoutube = /.*?youtube.com\/watch\?v=[\w-]+/i.test($player[0].href);
            var isiDevice = /iPad|iPhone|iPod/i.test(navigator.userAgent);
            var $splashImg = $player.find("img");
            if (isYoutube && isiDevice) {
                var $play = $('<img src="/uos/_assets/rbcvideoplayer/images/play-icon-splash.png" width="65" height="65" />');
                var playTop = Math.round($player.height()/2 - 32); // $play.height()/2 = 65/2 = ~ 32
                var playLeft = Math.round($player.width()/2 - 32); // $play.width()/2 = 65/2 = ~ 32
                $player.css("position", "relative");
                $play.prependTo($player).css({ position: "absolute", top: playTop+"px", left: playLeft+"px" });
                return;
            }

            // create outer container (around both $player and control bar)
            var $container = $player
                .wrap('<div class="rbcvideoplayer-container"></div>')
                .parent(".rbcvideoplayer-container");

            // modify href of youtube vids to conform to "api:..." format required by flowplayer youtube plugin
            $player[0].href = $player[0].href.replace(/.*?youtube.com\/watch\?v=([\w-]+)/i, "api:$1");

            // flowplayer playlist (with splash image as first clip; for 2nd clip, flowplayer will automatically get url from player element's href)
            var playlist = [
                { url: $splashImg[0].src, scaling: "orig" },
                { scaling: "fit", autoBuffering: true, autoPlay: false, captionUrl: settings.captions || null }
            ];

            // flowplayer common clip for youtube video
            var clip = {};
            if (isYoutube) {
                clip = {
                    provider: "youtube",
                    urlResolvers: "youtube"
                };
            }

            // flowplayer config
            var flowplayerConfig = $.extend({
                key: flowplayerKey,
                playlist: playlist,
                clip: clip,
                play: {
                    label: null,
                    replayLabel: settings.lang == "fr" ? REPLAY_FR: REPLAY_EN
                },
                plugins: {
                    controls: null,
                    /*
                    youtube: isYoutube ? {
                        url: "/uos/_assets/rbcvideoplayer/flowplayer/flowplayer.youtube-3.2.7.swf"
                    } : null,
                    */
                    youtube: {
									url:"/uos/_assets/rbcvideoplayer/flowplayer/flowplayer.youtube-3.2.7.swf",
									loadOnStart: false,
					                onVideoRemoved: function() {
					                    console.log("Video Removed");
					                },
					                onVideoError: function() {
					                    console.log("Incorrect Video ID");
					                },
					                onEmbedError: function() {
					                    console.log("Embed Not Allowed");
                		}
					},
                    captions: settings.captions ? {
                        url: "/uos/_assets/rbcvideoplayer/flowplayer/flowplayer.captions-3.2.8.swf",
                        captionTarget: 'content',
                        button: null
                    } : null,
                    content: settings.captions ? {
                        url: "/uos/_assets/rbcvideoplayer/flowplayer/flowplayer.content-3.2.8.swf",
                        bottom: 0,
                        height: 44,
                        width: '100%',
                        opacity: 0.95,
                        backgroundColor: "#e0e4ef",
                        backgroundGradient: "none",
                        borderRadius: 0,
                        border: 0,
                        style: {
                            body: {
                                fontSize: 13,
                                fontFamily: "Arial",
                                textAlign: "center",
                                color: "#000000"
                            }
                        }
                    } : null
                }
            }, settings.flowplayerConfig || {});

            // create flowplayer instance
            var player = flowplayer(id, settings.flowplayerParams, flowplayerConfig).onBeforeUnload(function() {
                return false; // this allows concurrent loading of multiple players, preventing load() from triggering unloading of other players
            }).ipad({
                //simulateiDevice: true,
                controls: true
            }).rbcControls({
                transcript: settings.transcript,
                captions: settings.captions,
                lang: settings.lang,
                scanInterval: settings.scanInterval,
                scanFactor: settings.scanFactor
            }).onLoad(function() {
                // since image clips in playlist (which we normally use as first clip for splash) don't work on iDevices, explicitly show splash image on top of video;
                // on mobile Safari, HTML5 video devours click events, so temporarily move the video until play starts (see http://roblaplaca.com/blog/2010/03/30/html5-video-on-the-ipad/)
                var $video = $("video", $player);
                $splashImg.insertBefore($video).css({ position: "absolute", top: "0", left: "0" });
                $video.css({ position: "absolute", left: "-9999px" });

                // add play button on top of splash
                var $play = $('<img src="/uos/_assets/rbcvideoplayer/images/play-icon-splash.png" width="65" height="65" />');
                var playTop = Math.round($splashImg.height()/2 - 32); // $play.height()/2 = 65/2 = ~ 32
                var playLeft = Math.round($splashImg.width()/2 - 32); // $play.width()/2 = 65/2 = ~ 32
                $play.insertAfter($splashImg).css({ position: "absolute", top: playTop+"px", left: playLeft+"px" });

                // restore video position and remove splash + play image
                $player.one("click.rbcControls", function() {
                    $video.css({ position: "static", left: "0" }).trigger("play");
                    $splashImg.remove();
                    $play.remove();
                    return false;
                });
            }).load();

            // prevent Flash movie from being tabbable, preventing inconsistent tab stops with JAWS
            //$player.find("object, embed").attr("tabindex", "-1");

        }); // end each()

    }; // end rbcvideoplayer()

    // automatically invoke rbcvideoplayer() on links with class "rbcvideoplayer"
    $(document).bind("ready", function() { // use bind() instead of ready() so this runs after any direct user calls to $.rbcvideoplayer() in $.ready(), to ensure options passed to $.rbcvideoplayer() (if any) take precedence
        $("a.rbcvideoplayer").rbcvideoplayer();
    });

})(jQuery);
