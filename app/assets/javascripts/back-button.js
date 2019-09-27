$(document).ready(function() {
    $('button.back-button')
        .click(function() {
            // If there is a history on the window, go back to the last location
            // Acts like pressing the back button on the window
            if (window.history.length) {
                window.history.back();
            } else {
                // If there is no history, navigate to the root of the site
                window.location.href = "/"
            }
        });
});