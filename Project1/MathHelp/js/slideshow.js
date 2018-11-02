var $ = function (id) { return document.getElementById(id); };

var imageCache = [];
var imageCounter = 0;

function runSlideShow(moveCounter) {
    imageCounter = (imageCounter + moveCounter) % imageCache.length;
    /* If we go backwards at the first image in the array */
    if (imageCounter < 0) {
        imageCounter = (imageCache.length - 1);
    }
    /* Pick our image */
    var image = imageCache[imageCounter];
    /* Change the image and caption */
    $("image").src = image.src;
    $("caption").firstChild.nodeValue = image.title;
}

window.onload = function () {
    var listNode = $("imageList");    // the ul element
    var links = listNode.getElementsByTagName("a");
    
    // Preload image, copy title properties, and store in array
    var i, link, image;
    for ( i = 0; i < links.length; i++ ) {
        link = links[i];
        image = new Image();
        image.src = link.getAttribute("href");
        image.title = link.getAttribute("title");
        imageCache[imageCache.length] = image;
    }

    // Attach start and pause event handlers
    $("previous").onclick = function() {
        runSlideShow(-1); /* Go to previous slide */
    };
    $("next").onclick = function() {
        runSlideShow(1); /* Go to next slide */
    };
};