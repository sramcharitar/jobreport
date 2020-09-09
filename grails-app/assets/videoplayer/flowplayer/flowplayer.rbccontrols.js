/*
 * RBC Controls - flowplayer plugin that implements HTML-based controlbar for RBC.
 * Requires jQuery + jQuery UI core + jQuery UI slider.
 *
 * @author Cliff Lee
 * @version 1.2.2
 */

/**
 * @param Object options An object containing plugin settings
 * - options.transcript: URL of transcript page (optional)
 * - options.captions: URL of captions XML file (optional)
 * - options.lang: "en" or "fr" (optional, defaults to "en")
 * - options.scanInterval: Interval (in ms) at which to perform rewinds / fast forwards while rewind / fast forward control is depressed (optional, defaults to 100)
 * - options.scanFactor: Amount (as a percentage of duration) to rewind / fast forward at each interval (optional, defaults to .05)
 */
(function($) {

    var DEFAULT_SCAN_INTERVAL = 100;
    var DEFAULT_SCAN_FACTOR = .05;
    
    var TIME_SLIDER_STEPS = 200; // number of steps in time slider
    var VOLUME_SLIDER_STEPS = 100; // number of steps in volume slider
    var TIME_SLIDER_UPDATE_INTERVAL = 200; // interval (in ms) at which to update the slider (to keep in sync with player time)
    var TIME_DISPLAY_UPDATE_INTERVAL = 200; // interval (in ms) at which to update the time display (to keep in sync with player time)

    var DICTIONARY = {
        en: {
            rewindTitle: "Rewind",
            rewindText: "Rewind",
            play: "Play",
            pause: "Pause",
            fastForwardTitle: "Fast forward",
            fastForwardText: "Fast forward",
            opensNewWindow: "(opens new window)",
            viewTranscript: "View Transcript",
            closedCaptioning: "Closed Captioning",
            //audioDescription: "Audio Description",
            mute: "Mute",
            unmute: "Unmute",
            timelineHandleTitle: "Timeline: {percent}%",
            timelineHandleText: "Timeline: {percent}%, press comma to rewind, press period to fast forward",
            volumeHandleTitle: "Volume: {percent}%",
            volumeHandleText: "Volume: {percent}%, press comma to lower, press period to raise"
        },
        fr: {
            rewindTitle: "Reculer",
            rewindText: "Reculer",
            play: "Lecture",
            pause: "Pause",
            fastForwardTitle: "Avancer",
            fastForwardText: "Avancer",
            opensNewWindow: "(ouvre une nouvelle fenêtre)",
            viewTranscript: "Voir la transcription",
            closedCaptioning: "Sous-titrage codé",
            //audioDescription: "Audio Description",
            mute: "Sourdine",
            unmute: "Désactiver sourdine",
            timelineHandleTitle: "Pourcentage écoulé : {percent} %",
            timelineHandleText: "Pourcentage écoulé : {percent} %, appuyez sur la touche de virgule pour reculer, et sur la touche de point pour avancer",
            volumeHandleTitle: "Volume : {percent} %",
            volumeHandleText: "Volume : {percent} %, appuyez sur la touche de virgule pour diminuer le volume, et sur la touche de point pour l’augmenter"
        }
    };
    
    /**
     * returns the largest number from an array of numbers
     */
    function max(numbers) {
        var result = numbers[0];
        for (var i = 1; i < numbers.length; i++) {
            if (numbers[i] > result) {
                result = numbers[i];
            }
        }
        return result;
    }
    
    /**
     * pad number with leading zeroes
     */
    function zeroPad(n, len) {
        var s = n.toString();
        if (s.length < len) {
            s = ('0000000000' + s).slice(-len);
        }
        return s;
    }

    /**
     * string variable substitution (from http://javascript.crockford.com/remedial.html)
     */
    if (!String.prototype.supplant) {
        String.prototype.supplant = function (o) {
            return this.replace(/{([^{}]*)}/g,
                function (a, b) {
                    var r = o[b];
                    return typeof r === 'string' || typeof r === 'number' ? r : a;
                }
            );
        };
    }

    flowplayer.addPlugin("rbcControls", function(options) {
    
        // define settings based on options and defaults
        var settings = {
            transcript: options.transcript || null,
            captions: options.captions || null,
            lang: options.lang || "en",
            scanInterval: options.scanInterval || DEFAULT_SCAN_INTERVAL,
            scanFactor: options.scanFactor || DEFAULT_SCAN_FACTOR
        };
        
        // select dictionary of strings based on language
        var dictionary = DICTIONARY[settings.lang] || DICTIONARY["en"];
        
        var player = this; // flowplayer's player
        var $player = $("#"+player.id()); // element to which flowplayer is applied

        // attach player functionality to HTML elements
        player.onLoad(function() {
        
            // disable HTML controlbar for iDevices (and HTML5 players in general) since some flowplayer events (e.g. onBegin) don't work
            if ($("video", $player).length > 0) {
                return;
            }
            
            // create HTML elements that comprise the control bar
            var $controlbar = $player.after('\
                <ul class="rbc-controlbar clear">\
                    <li class="rewind"><button title="' + dictionary["rewindTitle"] + '">' + dictionary["rewindText"] + '</button></li>\
                    <li class="play-pause"><button title="' + dictionary["play"] + '">' + dictionary["play"] + '</button></li>\
                    <li class="fast-forward"><button title="' + dictionary["fastForwardTitle"] + '">' + dictionary["fastForwardText"] + '</button></li>\
                    <li class="time-slider"><span class="rail-left"></span><span class="rail-right"></span></li>\
                    <li class="time-display"><!-- appease IE --></li>\
                    <li class="ie6-linebreak"><!-- appease IE --></li>\
                    ' + (settings.transcript ? '<li class="transcript"><a href="' + settings.transcript + '" onclick="return popupHelp(this.href)" title="' + dictionary["opensNewWindow"] + '" target="_blank" class="linkedtextandicon"><span>' + dictionary["viewTranscript"] + '</span> <img src="/uos/_assets/rbcvideoplayer/images/blank.gif" alt="' + dictionary["opensNewWindow"] + '" width="16" height="16" class="icon" /></a></li>' : '') + '\
                    ' + (settings.transcript && settings.captions ? '<li class="divider"><!-- appease IE --></li>' : '') + '\
                    ' + (settings.captions ? '<li class="captions"><input type="checkbox" name="captions" id="' + player.id() + '-captions" /> <label for="' + player.id() + '-captions"><span>' + dictionary["closedCaptioning"] + '</span> <img src="/uos/_assets/rbcvideoplayer/images/blank.gif" alt="" width="16" height="16" class="icon" /></label></li>' : '') + '\
                    <li class="sound">\
                        <div class="mute-unmute"><button title="' + dictionary["mute"] + '">' + dictionary["mute"] + '</button></div>\
                        <div class="volume-slider"><span class="rail-left"></span><span class="rail-right"></span></div>\
                    </li>\
                </ul>\
            ').next("ul.rbc-controlbar");
            if (settings.captions && !settings.transcript) {
                $(".captions", $controlbar).css("clear", "both");
            }
            
            // play/pause
            var $playPause = $(".play-pause", $controlbar);
            var $playPauseButton = $("button", $playPause);
            $player.one("activate.rbcControls", function() {
                $playPauseButton.bind("click.rbcControls", function() {
                    $playPause.toggleClass("playing");
                    player.toggle();
                    if ($playPause.hasClass("playing")) {
                        $playPauseButton.attr("title", dictionary["pause"]).text(dictionary["pause"]);
                    } else {
                        $playPauseButton.attr("title", dictionary["play"]).text(dictionary["play"]);
                    }
                    return false;
                }).bind("mouseenter.rbcControls", function() {
                    $playPauseButton.addClass("hover");
                }).bind("mouseleave.rbcControls", function() {
                    $playPauseButton.removeClass("hover");
                }).bind("focus.rbcControls", function() {
                    $playPauseButton.addClass("focus");
                }).bind("blur.rbcControls", function() {
                    $playPauseButton.removeClass("focus");
                });
                player.onBegin(function() {
                    $playPause.addClass("playing");
                    $playPauseButton.attr("title", dictionary["pause"]).text(dictionary["pause"]);
                });
                player.onResume(function() {
                    $playPause.addClass("playing");
                    $playPauseButton.attr("title", dictionary["pause"]).text(dictionary["pause"]);
                });
                player.onFinish(function() {
                    $playPause.removeClass("playing");
                    $playPauseButton.attr("title", dictionary["play"]).text(dictionary["play"]);
                });
                player.onPause(function() {
                    $playPause.removeClass("playing");
                    $playPauseButton.attr("title", dictionary["play"]).text(dictionary["play"]);
                });
            });

            // rewind
            var $rewind = $(".rewind", $controlbar);
            var $rewindButton = $("button", $rewind);
            $player.one("activate.rbcControls", function() {
                var rewinding = false;
                var rewindState;
                var rewindIntervalID;
                function rewind() {
                    var newPosition = player.getTime() - settings.scanFactor * player.getClip().fullDuration;
                    player.seek(newPosition <= 0 ? 0 : newPosition);
                    updateTimeSlider();
                }
                $rewindButton.bind("mousedown.rbcControls", function(event) {
                    rewindState = player.getState();
                    if (rewinding || rewindState <= 2) { // -1=unloaded, 0=loaded, 1=unstarted, 2=buffering, 3=playing, 4=paused, 5=ended
                        return false;
                    }
                    $rewindButton.data("mousedown", true);
                    $rewindButton.focus();
                    rewinding = true;
                    rewind();
                    rewindIntervalID = setInterval(rewind, settings.scanInterval);
                    return false;
                }).bind("click.rbcControls", function() {
                    if ($rewindButton.data("mousedown")) { // this is for keyboard users only, avoiding keydown to account for JAWS which devours keyboard events for most keys, particularly enter key
                        return false;
                    }
                    rewind();
                    return false;
                }).bind("mouseenter.rbcControls", function() {
                    $rewindButton.addClass("hover");
                }).bind("mouseleave.rbcControls", function() {
                    $rewindButton.removeClass("hover");
                }).bind("focus.rbcControls", function() {
                    $rewindButton.addClass("focus");
                }).bind("blur.rbcControls", function() {
                    $rewindButton.removeClass("focus");
                });
                $(document).bind("mouseup.rbcControls", function() {
                    $rewindButton.removeData("mousedown");
                    clearInterval(rewindIntervalID);
                    /*
                    if (rewindState == "PLAYING") {
                        player.play(true);
                    } else if (rewindState == "PAUSED") {
                        player.pause(true);
                    }
                    */
                    rewinding = false;
                });
            });
            
            // fast forward
            var $fforward = $(".fast-forward", $controlbar);
            var $fforwardButton = $("button", $fforward);
            $player.one("activate.rbcControls", function() {
                var fforwarding = false;
                var fforwardState;
                var fforwardIntervalID;
                function fforward() {
                    var duration = player.getClip().fullDuration;
                    var newPosition = player.getTime() + settings.scanFactor * duration;
                    player.seek(newPosition >= duration ? duration : newPosition);
                    updateTimeSlider();
                }
                $fforwardButton.bind("mousedown.rbcControls", function(event) {
                    fforwardState = player.getState();
                    if (fforwarding || fforwardState <= 2 || fforwardState == 5) { // -1=unloaded, 0=loaded, 1=unstarted, 2=buffering, 3=playing, 4=paused, 5=ended
                        return false;
                    }
                    $fforwardButton.data("mousedown", true);
                    $fforwardButton.focus();
                    fforwarding = true;
                    fforward();
                    fforwardIntervalID = setInterval(fforward, settings.scanInterval);
                    return false;
                }).bind("click.rbcControls", function() {
                    if ($fforwardButton.data("mousedown")) { // this is for keyboard users only, avoiding keydown to account for JAWS which devours keyboard events for most keys, particularly enter key
                        return false;
                    }
                    fforward();
                    return false;
                }).bind("mouseenter.rbcControls", function() {
                    $fforwardButton.addClass("hover");
                }).bind("mouseleave.rbcControls", function() {
                    $fforwardButton.removeClass("hover");
                }).bind("focus.rbcControls", function() {
                    $fforwardButton.addClass("focus");
                }).bind("blur.rbcControls", function() {
                    $fforwardButton.removeClass("focus");
                });
                $(document).bind("mouseup.rbcControls", function() {
                    $fforwardButton.removeData("mousedown");
                    clearInterval(fforwardIntervalID);
                    /*
                    if (fforwardState == "PLAYING") {
                        player.play(true);
                    } else if (fforwardState == "PAUSED") {
                        player.pause(true);
                    }
                    */
                    fforwarding = false;
                });
            });
            
            // time display
            var $timeDisplay = $(".time-display", $controlbar);
            $timeDisplay.text("00:00/00:00");
            function updateTimeDisplay() {
                var position = player.getTime();
                var duration = player.getClip().fullDuration;
                var positionMinutes = Math.floor(position / 60) || 0;
                var positionSeconds = Math.floor(position % 60) || 0;
                var durationMinutes = Math.floor(duration / 60) || 0;
                var durationSeconds = Math.floor(duration % 60) || 0;
                $timeDisplay.text(zeroPad(positionMinutes, 2) + ":" + zeroPad(positionSeconds, 2) + "/" + zeroPad(durationMinutes, 2) + ":" + zeroPad(durationSeconds, 2));
            };
            var timeDisplayIntervalID;
            player.onBegin(function() {
                clearInterval(timeDisplayIntervalID);
                timeDisplayIntervalID = setInterval(updateTimeDisplay, TIME_DISPLAY_UPDATE_INTERVAL);
            });
            player.onResume(function() {
                clearInterval(timeDisplayIntervalID);
                timeDisplayIntervalID = setInterval(updateTimeDisplay, TIME_DISPLAY_UPDATE_INTERVAL);
            });
            /*
            player.onPause(function() {
                clearInterval(timeDisplayIntervalID);
                updateTimeDisplay();
            });
            */
            player.onFinish(function() {
                clearInterval(timeDisplayIntervalID);
                $timeDisplay.text( $timeDisplay.text().replace(/^\d{2,}:\d{2}/, "00:00") );
            });
            
            // time slider
            var $timeSlider = $(".time-slider", $controlbar);
            $timeSlider.addClass("inactive");
            $timeSlider.width(max([$player.width(), $controlbar.width()]) - $rewind.outerWidth(true) - $playPause.outerWidth(true) - $fforward.outerWidth(true) - $timeDisplay.outerWidth(true) - 33); // 33px = left + right margins of $timeSlider + 1px for IE6/7
            $player.one("activate.rbcControls", function() {
                $timeSlider.bind("click.rbcControls keydown.rbcControls", function(event) {
                    if (event.type == "keydown" && event.which != 13) {
                        return;
                    }
                    if ($timeSlider.hasClass("inactive")) {
                        player.play();
                    }
                });
            });
            function createTimeSlider() {
                if (!$timeSlider.hasClass("inactive")) {
                    return;
                } else {
                    var duration = player.getClip(1).fullDuration; // assume clip 0 is splash, clip 1 is video
                    if (player.getState() == -1 || !duration || duration <= 0) { // -1=unloaded
                        setTimeout(createTimeSlider, TIME_SLIDER_UPDATE_INTERVAL);
                        return;
                    }
                    $timeSlider.removeClass("inactive");
                    $timeSlider.slider({
                        range: "min",
                        min: 0,
                        max: duration,
                        step: duration / TIME_SLIDER_STEPS,
                        value: 0,
                        start: function(event, ui) {
                            $timeSlider.data("disableUpdates", true); // prevent player from updating slider while actively sliding
                            $("body").css("cursor", "e-resize");
                        },
                        slide: function(event, ui) {
                            //var value = $timeSlider.slider("value");
                            //player.seek(Math.round(value));
                            //$(".ui-slider-handle", $timeSlider).attr("title", dictionary["timelineHandleTitle"].supplant({ percent: Math.round(value/duration*100) })).find(".instructions").text(dictionary["timelineHandleText"].supplant({ percent: Math.round(value/duration*100) }));
                        },
                        stop: function(event, ui) {
                            $("body").css("cursor", "default");
                            var value = $timeSlider.slider("value");
                            player.seek(Math.round(value));
                            $(".ui-slider-handle", $timeSlider).attr("title", dictionary["timelineHandleTitle"].supplant({ percent: Math.round(value/duration*100) })).find(".instructions").text(dictionary["timelineHandleText"].supplant({ percent: Math.round(value/duration*100) }));
                            //setTimeout(function() { // minimize handle jumpiness that occurs when slider stop updates player time via player.seek(), while at the same time player is trying to update slider; this happens because # slider steps does not necessarily match the # seconds of clip
                                $timeSlider.data("disableUpdates", false);
                            //}, 500);
                        }
                    }).find(".ui-slider-handle")
                        .attr("title", dictionary["timelineHandleTitle"].supplant({ percent: Math.round($timeSlider.slider("value")/duration*100) }))
                        .append('<span class="instructions">' + dictionary["timelineHandleText"].supplant({ percent: Math.round($timeSlider.slider("value")/duration*100) }) + '</span>');
                    // allow comma (188) as alternative to arrow left and period (190) as alternative to arrow right as workaround for JAWS which steals keydown events for
                    // arrow keys and never gives them back
                    $(".ui-slider-handle", $timeSlider).bind("keydown.rbcControls", function(event) {
                        if (event.which == 188) {
                            event.keyCode = event.which = 37;
                            $(this).trigger(event);
                        } else if (event.which == 190) {
                            event.keyCode = event.which = 39;
                            $(this).trigger(event);
                        }
                    });
                }
            };
            createTimeSlider();
            function updateTimeSlider() {
                if (!$timeSlider.hasClass("inactive") && !$timeSlider.data("disableUpdates")) {
                    $timeSlider.slider("value", player.getTime());
                    $timeSlider.find(".ui-slider-handle").attr("title", dictionary["timelineHandleTitle"].supplant({ percent: Math.round($timeSlider.slider("value")/$timeSlider.slider("option", "max")*100) }));
                }
            };
            var timeSliderIntervalID;
            player.onBegin(function() {
                createTimeSlider();
                //clearInterval(timeSliderIntervalID);
                timeSliderIntervalID = setInterval(updateTimeSlider, TIME_SLIDER_UPDATE_INTERVAL);
            });
            player.onResume(function() {
                clearInterval(timeSliderIntervalID);
                timeSliderIntervalID = setInterval(updateTimeSlider, TIME_SLIDER_UPDATE_INTERVAL);
            });
            /*
            player.onPause(function() {
                clearInterval(timeSliderIntervalID);
                updateTimeSlider();
            });
            */
            player.onStop(function() {
                clearInterval(timeSliderIntervalID);
            });
            player.onFinish(function() {
                clearInterval(timeSliderIntervalID);
                $timeSlider.slider("destroy").addClass("inactive");
            });
            
            // only activate rewind, play/pause, fast forward, and timeline-click controls when video clip is ready to play;
            // assumes first clip is splash, 2nd clipp is video
            player.getClip(1).onBegin(function() {
                $player.trigger("activate.rbcControls");
            });
            
            // workaround some Youtube videos not being able to start playing at 0 (problem in flowplayer 3.2.8; fixed in 3.2.10 [maybe 3.2.9 too, but untested])
            /*
            var ytWorkaround = function() {
                var volume = player.getVolume();
                player.setVolume(0);
                player.seek(.01);
                //player.seek(0);
                player.setVolume(volume);
            };
            player.getClip(1).onBufferFull(function() {
                ytWorkaround();
                ytWorkaround = function() {};
            });
            */

            // captions
            if (settings.captions) {
                $(".captions", $controlbar).bind("mouseenter.rbcControls", function() { // for IE6 where :hover pseudo-class selector only works on links, thus CSS in stylesheet doesn't work
                    $("label", this).css({
                        color: "#000",
                        cursor: "pointer"
                    });
                }).bind("mouseleave.rbcControls", function() {
                    $("label", this).css({
                        color: "#002888",
                        cursor: "default"
                    });
                });
                $(".captions input:checkbox", $controlbar).bind("focus.rbcControls", function() {
                    $(this).next("label").css({
                        backgroundColor: "#e5ebf2",
                        color: "#000"
                    });
                }).bind("blur.rbcControls", function() {
                    $(this).next("label").css({
                        backgroundColor: "transparent",
                        color: "#002888"
                    });
                });
                $(".captions input:checkbox", $controlbar).bind("click.rbcControls", function() {
                    if ($(this).is(":checked")) {
                        //player.getClip().update({ showCaptions: true });
                        player.getPlugin("content").show();
                    } else {
                        //player.getClip().update({ showCaptions: false });
                        player.getPlugin("content").hide();
                    }
                }).triggerHandler("click.rbcControls");
            }
            
            // mute/unmute
            var $muteUnmute = $(".sound .mute-unmute", $controlbar);
            var $muteUnmuteButton = $("button", $muteUnmute);
            $muteUnmuteButton.bind("click.rbcControls", function() {
                if (player.getStatus().muted) {
                    player.unmute();
                    $muteUnmute.removeClass("muted");
                    $muteUnmuteButton.attr("title", dictionary["mute"]).text(dictionary["mute"]);
                } else {
                    player.mute(true);
                    $muteUnmute.addClass("muted");
                    $muteUnmuteButton.attr("title", dictionary["unmute"]).text(dictionary["unmute"]);
                }
                return false;
            });
            if (player.getStatus().muted) {
                $muteUnmute.addClass("muted");
                $muteUnmuteButton.attr("title", dictionary["unmute"]).text(dictionary["unmute"]);
            } else {
                $muteUnmute.removeClass("muted");
                $muteUnmuteButton.attr("title", dictionary["mute"]).text(dictionary["mute"]);
            }
            
            // volume slider
            var $volumeSlider = $(".sound .volume-slider", $controlbar);
            $volumeSlider.slider({
                range: "min",
                min: 0,
                max: 100,
                step: 100 / VOLUME_SLIDER_STEPS,
                value: player.getVolume(),
                start: function(event, ui) {
                    $("body").css("cursor", "e-resize");
                },
                slide: function(event, ui) {
                    var value = $volumeSlider.slider("value");
                    player.setVolume(value);
                    $(".ui-slider-handle", $volumeSlider).attr("title", dictionary["volumeHandleTitle"].supplant({ percent: value })).find(".instructions").text(dictionary["volumeHandleText"].supplant({ percent: value }));
                },
                stop: function(event, ui) {
                    var value = $volumeSlider.slider("value");
                    player.setVolume(value);
                    $(".ui-slider-handle", $volumeSlider).attr("title", dictionary["volumeHandleTitle"].supplant({ percent: value })).find(".instructions").text(dictionary["volumeHandleText"].supplant({ percent: value }));
                    $("body").css("cursor", "default");
                }
            }).bind("click.rbcControls", function() {
                return false;
            }).find(".ui-slider-handle")
                .attr("title", dictionary["volumeHandleTitle"].supplant({ percent: $volumeSlider.slider("value") }))
                .append('<span class="instructions">' + dictionary["volumeHandleText"].supplant({ percent: $volumeSlider.slider("value") }) + '</span>');
            // allow comma (188) as alternative to arrow left and period (190) as alternative to arrow right as workaround for JAWS which steals keydown events for
            // arrow keys and never gives them back
            $(".ui-slider-handle", $volumeSlider).bind("keydown.rbcControls", function(event) {
                if (event.which == 188) {
                    event.keyCode = event.which = 37;
                    $(this).trigger(event);
                } else if (event.which == 190) {
                    event.keyCode = event.which = 39;
                    $(this).trigger(event);
                }
            });
            
        }); // end player.onLoad()

        return player;

    }); // end flowplayer.addPlugin()

})(jQuery);
