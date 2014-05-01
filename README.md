Dart-Redmine-Spent-Time-Visualizer
==================================

This web application visualizes the spend time of each team member in a redmine project. All you need to do is to export the spend time data as a csv-file and import it. The application then parses all the data and makes them comparable in a radar chart/spider chart.

See the online demo: http://h2284704.stratoserver.net/DartRedmineSpentTimeVisualizer/index.html

It is also possible to define the timespan in which the time spent should be calculated. For this purpose I used the JQRangeSlider (http://ghusse.github.io/jQRangeSlider/index.html) from Guillaume Gautreau (https://github.com/ghusse). It was very complicated to integrate it with Google Dart. The library js.dart works fine but it was very complicated to get the current selected timespan, because the conversion of the DateTime object from Javascript to Google Dart failed. It worked with a little workaround and the application compiles to plain Javascript to run in every modern browser.

I programmed this application in the course "visualization" at the Harz University of Applied Sciences. The task was to create a web application with Javascript, that uses the library d3.js to visualize a lot of data in a way the user instantly understands.

The app uses the library d3, which was partly ported to Dart by Richard Lincoln (https://github.com/rwl): d3.dart (https://github.com/rwl/d3.dart.git).