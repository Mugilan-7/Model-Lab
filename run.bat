@echo off
echo Compiling and initializing database...
javac -cp "webapp\WEB-INF\lib\sqlite-jdbc.jar" InitDB.java
java -cp ".;webapp\WEB-INF\lib\sqlite-jdbc.jar;webapp\WEB-INF\lib\slf4j-api-1.7.36.jar" InitDB

echo Deploying webapp to Tomcat...
xcopy /s /y "webapp\*" "apache-tomcat-9.0.85\webapps\ROOT\"

echo Starting Tomcat...
set JAVA_HOME=C:\Program Files\Java\jdk-24
set CATALINA_HOME=%CD%\apache-tomcat-9.0.85
call "%CATALINA_HOME%\bin\catalina.bat" start

echo Opening application in browser...
start http://localhost:8080/

echo Application is now running!
