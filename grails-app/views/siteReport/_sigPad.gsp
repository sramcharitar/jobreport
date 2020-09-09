<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <link rel="stylesheet" href="css/signature-pad.css">

    <!--[if IE]>
    <link rel="stylesheet" type="text/css" href="css/ie9.css">
  <![endif]-->

</head>
<body onselectstart="return false">

<div id="signature-pad" class="signature-pad">
    <div class="signature-pad--body">
        <canvas></canvas>
    </div>
    <div class="signature-pad--footer">
        <div class="description">Sign above</div>

        <div class="signature-pad--actions">
            <div>
                <button type="button" class="button clear" data-action="clear">Clear</button>
            </div>
            <div>
                <button type="button" class="button save" data-action="save-png">Save as PNG</button>
            </div>
        </div>
    </div>
</div>

<script src="js/signature_pad.umd.js"></script>
<script src="js/app.js"></script>
</body>
</html>
