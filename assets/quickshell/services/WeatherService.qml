pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: root

    property string city: "Aachen"

    property string weatherIcon: ""
    property string temperature: ""
    property string tooltip: "Wether is loading..."

    function fetchWeather() {
        var xhr = new XMLHttpRequest();
        var url = "https://wttr.in/" + city + "?format=%c|%t";

        xhr.open("GET", url);
        xhr.setRequestHeader("User-Agent", "curl/7.64.1");

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    var response = xhr.responseText;

                    response = response.split('\n')[0];

                    if (response.trim() === "" || response.indexOf("Error") !== -1 || response.indexOf("Unknown") !== -1 || response.indexOf("<html") !== -1) {
                        root.weatherIcon = "❌";
                        root.temperature = "N/A";
                        root.tooltip = "Weather service issue";
                        return;
                    }

                    response = response.replace(/\x1b\[[0-9;]*m/g, '').replace(/\+/g, '').trim();

                    var parts = response.split("|");
                    if (parts.length === 2) {
                        root.weatherIcon = parts[0].trim();
                        root.temperature = parts[1].trim();
                    } else {
                        root.temperature = response; 
                    }

                    fetchTooltip();
                } else {
                    root.weatherIcon = "❌";
                    root.temperature = "N/A";
                    root.tooltip = "HTTP Error " + xhr.status;
                }
            }
        }
        xhr.send();
    }

    function fetchTooltip() {
        var xhr = new XMLHttpRequest();
        var url = "https://wttr.in/" + city + "?format=%l:+%C+%t+%w+%m";

        xhr.open("GET", url);

        xhr.setRequestHeader("User-Agent", "curl/7.64.1");

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                var response = xhr.responseText;

                response = response.split('\n')[0];

                response = response
                    .replace(/\x1b\[[0-9;]*m/g, '')
                    .replace(/\+/g, '')
                    .replace(/\s+/g, ' ')
                    .trim();

                root.tooltip = response;
            }
        }
        xhr.send();
    }

    Timer {
        interval: 1800000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.fetchWeather()
    }
}