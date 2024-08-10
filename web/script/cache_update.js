if ('serviceWorker' in navigator) {
    window.addEventListener('load', function () {
        //getting rid of undesired cache before running the app
        var seconds = new Date().getTime()
        xmlhttp = new XMLHttpRequest();
        xmlhttp.open("GET", '/version.txt?v=' + seconds, true);
        xmlhttp.onload = function () {
            if (xmlhttp.status == 200) {
                var buildNumber = xmlhttp.responseText.split('+')[1];
                var currentBuildNumber = window.localStorage.getItem('buildNumber');

                if (currentBuildNumber && currentBuildNumber != buildNumber) {
                    caches.delete('flutter-app-manifest');
                    caches.delete('flutter-temp-cache');
                    caches.delete('flutter-app-cache');
                }

                window.localStorage.setItem('buildNumber', buildNumber);
            }
            navigator.serviceWorker.register('flutter_service_worker.js');
        }
        xmlhttp.error = function () { navigator.serviceWorker.register('flutter_service_worker.js'); }
        xmlhttp.abort = function () { navigator.serviceWorker.register('flutter_service_worker.js'); }
        xmlhttp.timeout = function () { navigator.serviceWorker.register('flutter_service_worker.js'); }
        xmlhttp.send();
    });
}
