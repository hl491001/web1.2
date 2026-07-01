@echo off
echo ========================================
echo   OrderDetail MS - Build and Deploy
echo ========================================

set JAVA_HOME=C:\Users\hl12345\.jdks\ms-11.0.30
set PATH=%JAVA_HOME%\bin;%PATH%

echo [1/3] Cleaning old build...
if exist web\WEB-INF\classes rmdir /s /q web\WEB-INF\classes
mkdir web\WEB-INF\classes

echo [2/3] Compiling Java sources...
set CP=web\WEB-INF\lib\servlet-api.jar;web\WEB-INF\lib\jsp-api.jar;web\WEB-INF\lib\mysql-connector-java-8.0.29.jar

javac -encoding UTF-8 -sourcepath src -d web\WEB-INF\classes -cp %CP% src\com\order\util\DBUtil.java src\com\order\entity\OrderDetail.java src\com\order\entity\Order.java src\com\order\dto\OrderDetailVO.java src\com\order\dao\OrderDao.java src\com\order\dao\OrderDetailDao.java src\com\order\servlet\EncodingFilter.java src\com\order\servlet\OrderDetailServlet.java

if %errorlevel% neq 0 (
    echo [ERROR] Compilation failed!
    pause
    exit /b 1
)
echo [OK] Compilation successful!

echo [3/3] Deploying to Tomcat...
set APPS=D:\Tomcat\ApacheTomcat\webapps
set APP=WebProject

if exist %APPS%\%APP% (
    echo    - Removing old deployment...
    rmdir /s /q %APPS%\%APP%
)
if exist %APPS%\%APP%.war del /q %APPS%\%APP%.war

echo    - Copying files...
xcopy /s /e /i /y web %APPS%\%APP% >nul

if exist D:\Tomcat\ApacheTomcat\work\Catalina\localhost\%APP% (
    rmdir /s /q D:\Tomcat\ApacheTomcat\work\Catalina\localhost\%APP%
)

echo [OK] Deployment complete!
echo ========================================
echo   URL: http://localhost:8080/WebProject/
echo ========================================
pause
