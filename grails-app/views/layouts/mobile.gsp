<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
    <head>
        <title><g:layoutTitle default="CHB Job Report"/></title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <asset:stylesheet src="w3.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <asset:stylesheet src="jquery.datetimepicker.css" />
        <asset:stylesheet src="signature-pad.css" />
        <asset:link rel="icon" href="chb.ico" type="image/x-icon" />
        <asset:link rel="shortcut icon" href="icons/favicon.ico" />
        <asset:javascript src="application.js" />
        <g:layoutHead />
    </head>
    <body>
        <g:layoutBody/>
        <div id="spinner" class="spinner" style="display:none;">
            <g:message code="spinner.alt" default="Loading&hellip;"/>
        </div>
    </body>
</html>