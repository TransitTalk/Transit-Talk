if (!window.location.href.includes("?") && window.location.pathname == "/") {
    geol();
}

function showLoc(position) {
    // p represents a position that is passed in, namely the pos element from above

    lat = position.coords.latitude;
    long = position.coords.longitude;

    // document.getElementById('stops_fav').innerHTML = "Found location at " + lat + ", " + long;

    window.location.href = window.location.href + "?&lat=" + lat + "&long=" + long;
}

function errorH(err) {
    if (err.code == 1)
        document.getElementById('stops_near').innerHTML = "Cannot find you since Location Services are blocked";
    else
        document.getElementById('stops_near').innerHTML = "Location hit an error: <i>" + err.message + "</i>";
}

function geol () {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showLoc, errorH);
    }
    else {
        document.getElementById('stops_near').innerHTML = "This functionality is not supported by your web browser.";
    }
}
