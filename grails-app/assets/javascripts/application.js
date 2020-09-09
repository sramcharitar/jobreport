// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better
// to create separate JavaScript files as needed.
//
//= require jquery-1.9.0.min
//= require jquery-migrate-1.1.1.min
//= require accordion
//= require calendar_encapsulated
//= require clickformore
//= require jobReport
//= require dynamicvalidation
//= require expand-collapse
//= require jquery.bgiframe
//= require jquery.cycle
//= require jquery.metadata
//= require jquery-ui
//= require modalwindow
//= require overlays
//= require sliders
//= require utilities
//= require jquery.datetimepicker.full.min
//= require jquery.signature-panel
//= require moment.min
//= require fullcalendar
//= require modaal.min.js
//
// require jquery-2.2.0.min
// require bootstrap
// require_tree .
// require_self


if (typeof jQuery !== 'undefined') {
    (function($) {
        $(document).ajaxStart(function() {
            $('#spinner').fadeIn();
        }).ajaxStop(function() {
            $('#spinner').fadeOut();
        });
    })(jQuery);
}
