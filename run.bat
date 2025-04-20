@echo off
echo Building the application...
call mvn clean package dependency:copy-dependencies

echo.
echo Starting the application...
echo.
echo Once the server is started, open your browser and navigate to http://localhost:8095
echo Press Ctrl+C to stop the server
echo.

set CLASSPATH=target\classes;target\dependency\*
java com.group7.Main
