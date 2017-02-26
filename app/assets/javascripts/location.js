geol();

function showLoc(position) {
    // p represents a position that is passed in, namely the pos element from above

    lat = position.coords.latitude;
    long = position.coords.longitude;

    document.write("Found location at " + lat + ", " + long);

}

function errorH(err) {
    if (err = 1) document.write("Cannot find you since Location Services are off.");
}

function geol () {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showLoc, errorH);
    }
    else {
        document.write("This functionality is not supported by your web browser.");
    }

}
