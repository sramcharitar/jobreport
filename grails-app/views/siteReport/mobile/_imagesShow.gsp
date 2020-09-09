
<div class="slideshow-container">
    <g:set var="imgCnt" value="${siteReport.siteImages?.size()}"/>
    <g:each var="document" in="${siteReport.siteImages}" status="i">
        <div class="mySlides fade">
            <div class="numbertext">${i+1} / ${imgCnt}</div>
            <img src="data:${document.contentType};base64,${document?.doc?.encodeBase64()}" style="width:100%"/>
            <div class="text">${document}</div>
        </div>
    </g:each>

    <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
    <a class="next" onclick="plusSlides(1)">&#10095;</a>

</div>
<br>

<div style="text-align:center">
    <g:each var="document" in="${siteReport.siteImages}" status="i">
        <span class="dot" onclick="currentSlide(${i+1})"></span>
    </g:each>
</div>

<script>
    var slideIndex = 1;
    showSlides(slideIndex);
    //var slideIndex = 0;
    //showSlides();

    function plusSlides(n) {
        showSlides(slideIndex += n);
    }

    function currentSlide(n) {
        showSlides(slideIndex = n);
    }

    function showSlides(n) {
        var i;
        var slides = document.getElementsByClassName("mySlides");
        var dots = document.getElementsByClassName("dot");
        if (n > slides.length) {slideIndex = 1}
        if (n < 1) {slideIndex = slides.length}
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        for (i = 0; i < dots.length; i++) {
            dots[i].className = dots[i].className.replace(" active", "");
        }
        slides[slideIndex-1].style.display = "block";
        dots[slideIndex-1].className += " active";
    }

    /*
    function showSlides() {
        var i;
        var slides = document.getElementsByClassName("mySlides");
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        slideIndex++;
        if (slideIndex > slides.length) {slideIndex = 1}
        slides[slideIndex-1].style.display = "block";
        setTimeout(showSlides, 4000); // Change image every 2 seconds
    }
    */
</script>